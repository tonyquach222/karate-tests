Feature: Invoices API

Background:
  * url karate.config.baseUrl

Scenario: Get all invoices
  Given path 'api/invoices'
  When method get
  Then status 200
