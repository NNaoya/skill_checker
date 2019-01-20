require 'test_helper'

class UsersearchesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get usersearches_index_url
    assert_response :success
  end

end
