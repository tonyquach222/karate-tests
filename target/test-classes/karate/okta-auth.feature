Feature: Okta Authentication

Background:
    * def basicAuth = karate.properties['basicAuth']
    * def oktaTokenUrl = karate.properties['oktaTokenUrl']
    * def oktaScopes = karate.properties['oktaScopes']

Scenario: Get access token
    Given url oktaTokenUrl
    And request { grant_type: 'client_credentials', scope: oktaScopes }
    And header Authorization = 'Basic ' + basicAuth
    When method POST
    Then status 200
    And def access_token = response.access_token
