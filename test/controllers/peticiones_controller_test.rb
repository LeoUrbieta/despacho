require "test_helper"

class PeticionesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get peticiones_path
    #get peticiones_index_url
    assert_response :success
  end
end
