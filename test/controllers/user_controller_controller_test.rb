require 'test_helper'

class UserControllerControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get user_controller_new_url
    assert_response :success
  end

  test "should get edit" do
    get user_controller_edit_url
    assert_response :success
  end

  test "should get show" do
    get user_controller_show_url
    assert_response :success
  end

end
