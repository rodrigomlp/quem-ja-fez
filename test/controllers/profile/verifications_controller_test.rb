require 'test_helper'

class Profile::VerificationsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get profile_verifications_show_url
    assert_response :success
  end

  test "should get update" do
    get profile_verifications_update_url
    assert_response :success
  end

end
