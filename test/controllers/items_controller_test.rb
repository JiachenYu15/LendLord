require 'test_helper'

class ItemsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.new(email: "example@example.com",
                     password: "example1")
    @person = Person.new(username: "test", firstname: "test", lastname: "test", telephone: "6471111111", state: "Ontario", country: "Canada", city: "Toronto", address: "80 Bloor St.", addressno:"80", user_id: @user.id)
    @item = Item.new(person_id: @person.id, deposit: 40, name: "test", description: "test description")
  end

  test "item route test" do
    assert_generates '/items', :controller => "items", :action => "index"
    assert_generates '/items/1', { :controller => "items", :action => "show", :id => "1" }
  end

  test "should redirect create when not logged in" do
    get '/items/new'
    assert_redirected_to '/users/sign_in'
  end

end
