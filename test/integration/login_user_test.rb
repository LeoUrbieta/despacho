require "test_helper"

class LoginUserTest < ActionDispatch::IntegrationTest

  def setup
    @usuario = User.create!(nombre_usuario: "Leo", password: "password", admin: false)
  end

  test "login a user" do
    sign_in_as(@usuario,"password")
    assert_redirected_to peticiones_path
    follow_redirect!
    assert_template 'peticiones/index'
  end
end
