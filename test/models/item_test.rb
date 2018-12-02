require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  def setup
    @item = Item.new(user_id: 3, deposit: 40, name: "test", description: "test description")
  end

  test "should be valid" do
    assert @item.valid?
  end

  test "user id should be present" do
    @item.user_id = nil
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