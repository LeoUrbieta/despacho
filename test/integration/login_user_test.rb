require "test_helper"

class LoginUserTest < ActionDispatch::IntegrationTest

  def setup
    @usuario = User.create!(nombre_usuario: "Leo", password: "password", admin: false)
    @peticion = Peticion.create!(nombre_trabajador: "Gerardo", apellido_paterno: "Gonzalez",
    apellido_materno: "Martinez", fecha_para_realizar_tramite: Date.parse("01-01-2001"), fecha_nacimiento: Date.parse("04-04-1984"),
    empresa_solicitante: "NEO S.A. DE C.V.", persona_solicitante: "Juan Sanchez", movimiento: "Baja")
  end

  test "login a user" do
    sign_in_as(@usuario,"password")
    assert_redirected_to peticiones_path
    follow_redirect!
    assert_template 'peticiones/index'
  end
end
