require "test_helper"

class PeticionesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @usuario = User.create!(nombre_usuario: "Leo", password: "password")
  end

  test "should get index" do
    sign_in_as(@usuario,"password")
    get peticiones_path
    #get peticiones_index_url
    assert_response :success
  end
end
