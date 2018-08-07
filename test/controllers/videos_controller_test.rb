require 'test_helper'

class VideosControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get videos_new_url
    assert_response :success
  end

end
