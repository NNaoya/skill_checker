require 'test_helper'

class UserskillsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get userskills_new_url
    assert_response :success
  end

end
