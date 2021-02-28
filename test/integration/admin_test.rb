require "test_helper"

class AdminTest < ActionDispatch::IntegrationTest

  def setup
    @usuario_admin = User.create!(nombre_usuario: "Leo", password: "password", admin: true)
    @peticion = Peticion.create!(nombre_trabajador: "Alfonso", apellido_materno: "Moreno", apellido_paterno: "Tapia",
                                rfc: "MOTA3511098Z4", empresa_solicitante: "ASESORES MF", persona_solicitante: "Juana",
                                movimiento: "Baja")
  end

  test "Si eres administrador, borra una petición" do
    sign_in_as(@usuario_admin,"password")
    assert_difference("Peticion.count", -1) do
      delete peticion_url(@peticion)
    end
    assert_redirected_to peticiones_path
  end

end
