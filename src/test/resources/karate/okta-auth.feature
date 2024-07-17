Feature: Okta Authentication

Scenario: Get access token
  Given url oktaTokenUrl
  And header Authorization = 'Basic ' + basicAuth
  And param grant_type = 'client_credentials'
  And param scope = oktaScopes
  When method post
  Then status 200
  * def access_token = response.access_token
