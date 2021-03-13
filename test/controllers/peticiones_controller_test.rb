require "test_helper"

class PeticionesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @usuario = User.create!(nombre_usuario: "Leo", password: "password")
    @peticion = Peticion.create!(nombre_trabajador: "Gerardo", apellido_paterno: "Gonzalez",
    apellido_materno: "Martinez", fecha_para_realizar_tramite: Date.parse("01-01-2001"), fecha_nacimiento: Date.parse("04-04-1984"),
    empresa_solicitante: "NEO S.A. DE C.V.", persona_solicitante: "Juan Sanchez", movimiento: "Baja")
  end

  test "should get index" do
    sign_in_as(@usuario,"password")
    get peticiones_path
    #get peticiones_index_url
    assert_response :success
  end
end
