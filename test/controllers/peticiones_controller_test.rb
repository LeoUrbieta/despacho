require "test_helper"

class PeticionesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @usuario = User.create!(nombre_usuario: "Leo", password: "password")
    @peticion = Peticion.create!(nombre_trabajador: "Gerardo", apellido_paterno: "Gonzalez",
    apellido_materno: "Martinez", fecha_para_realizar_tramite: Date.parse("01-01-2001"), fecha_nacimiento: Date.parse("04-04-1984"),
    movimiento: "Baja", empresa_solicitante: "NEOENKIMDU S.A. DE C.V", persona_solicitante: "Gregorio Ojeda", folio: 5)
  end

  test "should get index" do
    sign_in_as(@usuario,"password")
    get peticiones_path
    assert_response :success
  end

  test "should create peticion" do
    post peticiones_path, params: {peticion: {:nombre_trabajador => "Julian",
                                              :apellido_materno => "Agro",
                                              :apellido_paterno => "Enriquez",
                                              :movimiento => "Alta",
                                              :persona_solicitante => "Neiva Orlando",
                                              :empresa_solicitante => "HELADOS BING SA DE CV"
                                              }}
    assert_redirected_to root_path
    assert_equal "Tu solicitud se envió con éxito con folio ##{@peticion.folio + 1}", flash[:success]
  end
end
