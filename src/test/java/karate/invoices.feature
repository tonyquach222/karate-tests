Feature: Invoices API

Background:
  * url karate.config.baseUrl

Scenario: Get all invoices
  Given path 'api/invoices'
  When method get
  Then status 200
  And print 'Response:', response
  And assert response != null
  And assert response.length > 0
  * match response[0].id == '#string'
  * match response[0].amount == '#number'

# Scenario: Get a specific invoice
#   Given path 'api/invoices/123' # Use a valid invoice ID here
#   When method get
#   Then status 200
#   And print 'Response:', response
#   And assert response != null
#   * match response.id == '123'
#   * match response.amount == '#number'
#   * match response.status == 'paid'

# Scenario: Create a new invoice
#   Given path 'api/invoices'
#   And request { "amount": 100.50, "status": "unpaid", "supplier": "Supplier A" }
#   When method post
#   Then status 201
#   And print 'Response:', response
#   * match response.id == '#string'
#   * match response.amount == 100.50
#   * match response.status == 'unpaid'

# Scenario: Update an existing invoice
#   Given path 'api/invoices/123' # Use a valid invoice ID here
#   And request { "status": "paid" }
#   When method put
#   Then status 200
#   And print 'Response:', response
#   * match response.id == '123'
#   * match response.status == 'paid'
