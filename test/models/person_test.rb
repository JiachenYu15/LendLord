require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  def setup
    @user = User.new(email: "example@example.com",
                     password: "example1")
    @person = Person.new(username: "test", firstname: "test", lastname: "test", telephone: "647-111-1111", state: "Ontario", country: "Canada", city: "Toronto", address: "80 Bloor St.", addressno:"80", imgurl: "", user_id: @user.id)
  end

  test "username should be present" do
    @person.username = nil
    assert_not @person.valid?
  end

  test "telephone should reject invalid format" do
    invalid_tel = %w[666-6666666 1234567890]
    invalid_tel.each do |tel|
      @person.telephone = tel
      assert_not @person.valid?
    end
  end
end
