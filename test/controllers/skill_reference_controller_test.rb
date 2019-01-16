require 'test_helper'

class SkillReferenceControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get skill_reference_index_url
    assert_response :success
  end

end
