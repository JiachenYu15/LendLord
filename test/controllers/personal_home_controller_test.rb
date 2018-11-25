require 'test_helper'

class PersonalHomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get personal_home_index_url
    assert_response :success
  end

end
