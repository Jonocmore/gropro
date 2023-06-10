require "test_helper"

class ResourcesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get resources_index_url
    assert_response :success
  end

  test "should get show" do
    get resources_show_url
    assert_response :success
  end
end
