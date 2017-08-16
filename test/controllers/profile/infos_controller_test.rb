require 'test_helper'

class Profile::InfosControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get profile_infos_edit_url
    assert_response :success
  end

end
