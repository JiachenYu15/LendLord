Given(/^I am on the homepage$/) do
  visit root_path
end

When(/^I click on login$/) do
  click_on "login"
end

Then(/^I should see the login page$/) do
  expect(page).to have_current_path(new_user_session_path)
end


# Log in
When("{string} logs in through login page with invalid data") do |user_name|
  visit new_user_session_path
  fill_in "email", :with => user_name + "@gmail.com"
  fill_in "password", :with => "testtest"
  click_on "login"
  expect(page).to have_text("Invalid Email or password.\nLog in\nEmail\nPassword\nRemember me\nSign up Forgot your password? Sign in with Facebook")

end

Then(/^I should see the home page$/) do
  expect(page).to have_current_path(root_path)
end

# Sign up
Given(/^I am on the signup page/) do
  visit new_user_registration_path
end

Given("I fill the form with the following data") do
  fill_in "email", :with => "test@gmail.com"
  fill_in "password", :with => "password"
  fill_in "password_confirmation", :with => "password"
  check("check_terms")
  click_on "sign_up"
end

Then(/^I should see the new profile page$/) do
  expect(page).to have_current_path(new_person_path)
end