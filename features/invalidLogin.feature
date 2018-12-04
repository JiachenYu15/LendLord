Feature: User logs in with invalid data

Scenario: user tries to log in
When "test" logs in through login page with invalid data
Then I should see the login page
