require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.new(email: "example@example.com",
                     password: "example1")
  end

  test "user route test" do
    assert_generates '/users', :controller => "users", :action => "index"
    assert_generates '/users/1', { :controller => "users", :action => "show", :id => "1" }
  end

  test "should get new" do
    get '/users/sign_up'
    assert_response :success
  end
end
