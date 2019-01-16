require 'test_helper'

class SkillRegistrationUpdateControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get skill_registration_update_index_url
    assert_response :success
  end

end
