require "test_helper"

class FriendControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get friend_index_url
    assert_response :success
  end

  test "should get show" do
    get friend_show_url
    assert_response :success
  end

  test "should get new" do
    get friend_new_url
    assert_response :success
  end

  test "should get create" do
    get friend_create_url
    assert_response :success
  end
end
