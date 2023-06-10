require "test_helper"

class PlantsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get plants_new_url
    assert_response :success
  end

  test "should get index" do
    get plants_index_url
    assert_response :success
  end
end
