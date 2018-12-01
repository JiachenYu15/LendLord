require 'test_helper'

class UserTest < ActiveSupport::TestCase

    def setup
        @user = User.new(username: "exampleuser", email: "user@example.com",
                         password: "example1", password_confirmation "example1")
    end

    test "should be valid" do
        assert @user.valid?
    end

    test "name should be present" do
        @user.username = "     "
        assert_not @user.valid?
    end

    test "email should be present" do
        @user.email = "     "
        assert_not @user.valid?
    end

    test "name should not be too long" do
        @user.username = "a" * 17
        assert_not @user.valid?
    end

    test "name should not be too long" do
        @user.username = "a" * 244 + "@example.com"
        assert_not @user.valid?
    end

    test "email validation should accept valid addresses" do
        valid_addresses = %w[tester@testre.com i@am.unhappy Core_JJ@LoL.org]
        valid_addresses.each do |valid_address|
            @user.email = valid_address
            assert @user.valid?, "#{valid_address.inspect} should be valid"
        end
    end

    test "email validation should reject invalid addresses" do
        invalid_addresses = %w[tester@testre,com iam.unhappy Core_JJ@LoL. Koreko@gae_go.com LendLord@76+345.cn]
        invalid_addresses.each do |invalid_address|
            @user.email = invalid_address
            assert_not @user.valid?, "#{invalid_address.inspect} should be valid"
        end
    end

end
