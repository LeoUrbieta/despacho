require "application_system_test_case"

class UsuarioExternosTest < ApplicationSystemTestCase
  setup do
    @usuario_externo = usuario_externos(:one)
    @usuario_externo_sin_peticiones = usuario_externos(:two)
    crear_y_entrar_como_usuario_system_test("user_usuario_externo", "user12345", true)
  end

  test "visiting the index" do
    visit usuario_externos_url
    assert_selector "h1", text: "Usuario externos"
  end

  test "should create usuario externo" do
    visit usuario_externos_url
    click_on "Nuevo Usuario Externo"

    correo_usuario = "example1@example.com"
    password = "supersecretpass"

    fill_in with: correo_usuario, id: "usuario_externo_nombre_usuario"
    fill_in with: password, id: "usuario_externo_password"
    fill_in with: password, id: "usuario_externo_password_confirmation"

    click_on "Crear Usuario externo"
    assert_text "Usuario externo fue creado exitosamente"
    assert_text correo_usuario
    assert_text "Email confirmado: false"
  end

  test "should update Usuario externo" do
    visit usuario_externo_url(@usuario_externo)
    click_on "Editar este Usuario Externo", match: :first
    correo_usuario = "example_actualizado@example.com"
    password = "supersecretpassactualizado"

    fill_in with: correo_usuario, id: "usuario_externo_nombre_usuario"
    fill_in with: password, id: "usuario_externo_password"
    fill_in with: password, id: "usuario_externo_password_confirmation"
    click_on "Actualizar Usuario externo"
    assert_text "Usuario externo fue actualizado correctamente"
    assert_text correo_usuario
  end

  test "should destroy Usuario externo si no hay peticiones asociadas" do
    visit usuario_externo_url(@usuario_externo_sin_peticiones)
    click_on "Destruir este Usuario Externo", match: :first
    assert_text "Usuario externo fue eliminado correctamente"
    assert_no_text @usuario_externo_sin_peticiones.nombre_usuario
  end

  test "cant destroy Usuario externo si tiene peticiones asociadas" do
    visit usuario_externo_url(@usuario_externo)
    click_on "Destruir este Usuario Externo", match: :first
    assert_selector "h2", text: "1 error impidieron completar tu solicitud"
    assert_text "El registro no puede ser eliminado pues existen peticiones dependientes"
    assert_text @usuario_externo.nombre_usuario
  end

  test "no puede haber 2 correos iguales" do
    visit usuario_externos_url
    click_on "Nuevo Usuario Externo"

    correo_usuario = "example@example.com"
    password = "supersecretpass"

    fill_in with: correo_usuario, id: "usuario_externo_nombre_usuario"
    fill_in with: password, id: "usuario_externo_password"
    fill_in with: password, id: "usuario_externo_password_confirmation"

    click_on "Crear Usuario externo"
    assert_selector "h2", text: "1 error impidieron completar tu solicitu"
    assert_text "Nombre usuario ya ha sido tomado"
  end
end
