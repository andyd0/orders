Feature: The order microservices back-end
    As a API User
    I need a RESTful catalog service
    So that I can keep track of all orders

Background:
    Given the following orders
        | id | customer_id | date             | status     | order_id | product_id | name   | quantity | price   |
        |  1 | 72          | 2017-12-24T09:29 | returned   | 1        | 14         | cup    | 2        | 10.12   |
        |  2 | 11          | 2018-01-25T09:30 | processing | 2        | 7          | box    | 1        | 5.32    |
        |  3 | 14          | 2018-02-25T09:30 | processing | 3        | 71         | phone  | 1        | 549.99  |
        |  4 | 15          | 2018-02-27T09:30 | processing | 4        | 72         | laptop | 1        | 999.32  |

Scenario: The server is running
    When I visit the "Home Page"
    Then I should see "Order RESTful Service" in the title
    And I should not see "404 Not Found"

Scenario: List all orders
    When I visit the "Home Page"
    And I press the "list" order button
    Then I should see "72" in the order results
    Then I should see "returned" in the order results
    And I should not see "kitty" in the order results

Scenario: List all items
    When I visit the "Home Page"
    And I press the "list" item button
    Then I should see "cup" in the item results
    And I should see "7" in the item results
    And I should not see "leo" in the item results

Scenario: Query a customer
    When I visit the "Home Page"
    And I set the "order_customer_id" to "11"
    And I press the "search" order button
    Then I should see the message "Success"
    And I should see "processing" in the order results

Scenario: Query an item
    When I visit the "Home Page"
    And I set the "item_name" to "laptop"
    And I press the "search" item button
    Then I should see the message "Success"
    And I should see "72" in the item results

Scenario: Read an order
    When I visit the "Home Page"
    And I set the "order_customer_id" to "11"
    And I press the "search" order Button
    And I press the "retrieve" order Button
    Then I should see "11" in the "order_customer_id" field
    Then I should see "2018-01-25T09:30" in the "order_date" field
    Then I should see "processing" in the "order_status" field
    Then I should see the message "Success"

Scenario: Read an item
    When I visit the "Home Page"
    And I set the "item_name" to "laptop"
    And I press the "search" item button
    And I press the "retrieve" item Button
    Then I should see "72" in the "item_product_id" field
    Then I should see "laptop" in the "item_name" field
    Then I should see "1" in the "item_quantity" field
    Then I should see "999.32" in the "item_price" field
    Then I should see the message "Success"

Scenario: Delete an item
    When I visit the "Home Page"
    And I set the "item_name" to "laptop"
    And I press the "search" item button
    And I press the "retrieve" item button
    And I press the "delete" item button
    Then I should see the message "Item has been Deleted!"

Scenario: Delete an order
    When I visit the "Home Page"
    And I set the "order_customer_id" to "11"
    And I press the "search" order Button
    And I press the "retrieve" item button
    And I press the "delete" order button
    Then I should see the message "Order has been Deleted!"

Scenario: Update an item
    When I visit the "Home Page"
    And I set the "item_name" to "laptop"
    And I press the "search" item button
    And I press the "retrieve" item button
    Then I should see "1" in the "item_quantity" field
    When I change "item_quantity" to "3"
    And I press the "update" item button
    Then I should see the message "Success"

Scenario: Update an order
    When I visit the "Home Page"
    And I set the "order_customer_id" to "11"
    And I press the "search" order Button
    When I change "order_customer_id" to "12"
    And I press the "update" order button
    Then I should see the message "Success"

Scenario: Create a order
    When I visit the "Home Page"
    And I set the "item_product_id" to "214"
    And I set the "item_name" to "banana"
    And I set the "item_quantity" to "10"
    And I set the "item_price" to "20.34"
    When I press the "create" item button
    And I set the "item_product_id" to "78"
    And I set the "item_name" to "laptop"
    And I set the "item_quantity" to "1"
    And I set the "item_price" to "642.34"
    When I press the "create" item button
    And I set the "item_product_id" to "28"
    And I set the "item_name" to "apple"
    And I set the "item_quantity" to "100"
    And I set the "item_price" to "60.24"
    When I press the "create" item button
    And I set the "order_customer_id" to "123"
    And I set the time "order_date" to "2018-02-27T19:35"
    And I set the "order_status" to "processing"
    When I press the "create" order button
    Then I should see the message "Success"
    And I should not see "404 Not Found"

Scenario: Cancel a order
    When I visit the "Home Page"
    And I set the "order_customer_id" to "11"
    And I press the "search" order Button
    And I press the "retrieve" order button
    And I press the "cancel" order button
    Then I should see "cancelled" in the "order_status" field
    And I should see the message "Order has been Canceled!"
