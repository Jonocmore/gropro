require "test_helper"

class RecommendationsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get recommendations_show_url
    assert_response :success
  end
end
