require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  def setup
    @user = User.new(email: "example@example.com",
                     password: "example1")
    @person = Person.new(username: "test", firstname: "test", lastname: "test", telephone: "6471111111", state: "Ontario", country: "Canada", city: "Toronto", address: "80 Bloor St.", addressno:"80", imgurl: "", user_id: @user.id)
    @item = Item.new(person_id: @person.id, deposit: 40, name: "test", is_available: true, is_deleted: false, description: "test description", image_link: "")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "person id should be present" do
    @item.person_id = nil
    assert_not @item.valid?
  end

  test "name should be present" do
    @item.name = nil
    assert_not @item.valid?
  end

  test "deposit validation should reject invalid deposit" do
    invalid_deposit = %w[test 1a test.com]
    invalid_deposit.each do |invalid_deposit|
      @item.deposit = invalid_deposit
      assert_not @item.valid?, "Deposit must be a number"
    end
  end
end