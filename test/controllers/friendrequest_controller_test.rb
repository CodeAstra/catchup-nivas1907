require "test_helper"

class FriendrequestControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get friendrequest_index_url
    assert_response :success
  end

  test "should get update" do
    get friendrequest_update_url
    assert_response :success
  end
end
