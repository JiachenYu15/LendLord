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
end