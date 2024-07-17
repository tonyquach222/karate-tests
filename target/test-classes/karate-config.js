function fn() {
  var config = {
      baseUrl: 'https://invoices-rpis.finance-test.cfadevelop.com/',
      apiEnvironment: 'dev',
      oktaScopes: 'fcr-api:read-invoice-suppliers fcr-api:publish-invoice-supplier-entity-types fcr-api:publish-invoice-suppliers'
  };

  karate.log('Initial config:', config);

  function execCommand(command) {
      var proc = java.lang.Runtime.getRuntime().exec(command);
      proc.waitFor();
      var reader = new java.io.BufferedReader(new java.io.InputStreamReader(proc.getInputStream()));
      var line = '';
      var output = '';
      while ((line = reader.readLine()) != null) {
          output += line;
      }
      return output;
  }

  var secretName = config.apiEnvironment + '-ots-rpis-xp-api-okta';
  var command = 'aws secretsmanager get-secret-value --secret-id ' + secretName + ' --query SecretString --output text';
  karate.log('Executing command:', command);

  var oktaCredsJson = execCommand(command);
  karate.log('Okta credentials JSON:', oktaCredsJson);

  if (!oktaCredsJson) {
      karate.log('Failed to retrieve Okta secrets from Secrets Manager');
      throw 'Failed to retrieve Okta secrets';
  }

  var oktaCreds = JSON.parse(oktaCredsJson);
  karate.log('Parsed Okta credentials:', oktaCreds);

  var oktaClientId = oktaCreds['okta-client-id'];
  var oktaClientSecret = oktaCreds['okta-client-secret'];
  var oktaTokenUrl = oktaCreds['okta-token-url'];

  var basicAuth = java.util.Base64.getEncoder().encodeToString((oktaClientId + ':' + oktaClientSecret).getBytes('utf-8'));
  karate.log('Basic Auth header:', basicAuth);

  var tokenResponse = karate.call('classpath:karate/okta-auth.feature', {
      basicAuth: basicAuth,
      oktaTokenUrl: oktaTokenUrl,
      oktaScopes: config.oktaScopes
  });
  karate.log('Token response:', tokenResponse);

  if (!tokenResponse || !tokenResponse.access_token) {
      karate.log('Failed to get access token from Okta');
      throw 'Failed to get access token from Okta';
  }

  config.accessToken = tokenResponse.access_token;
  karate.log('Access token:', config.accessToken);

  karate.configure('httpClientInstance', { readTimeout: 60000 });

  return config;
}
