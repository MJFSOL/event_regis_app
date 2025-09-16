require "test_helper"

class GuestControllerTest < ActionDispatch::IntegrationTest
  test "should get landing" do
    get guest_landing_url
    assert_response :success
  end
end
