require 'test_helper'

class Profile::MeetingsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get profile_meetings_index_url
    assert_response :success
  end

end
