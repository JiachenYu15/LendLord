require 'test_helper'

class ItemsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.new(username: "exampleuser", email: "user@example.com",
                     password: "example1", password_confirmation: "example1")
    @item = Item.new(user_id: @user.id, deposit: 40, name: "test", description: "test description")
  end

  test "item route test" do
    assert_generates '/items', :controller => "items", :action => "index"
    assert_generates '/items/1', { :controller => "items", :action => "show", :id => "1" }
  end

  test "should redirect create when not logged in" do
    get '/items/new'
    assert_redirected_to login_url
  end

end
