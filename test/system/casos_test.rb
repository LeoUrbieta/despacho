require "application_system_test_case"

class CasosTest < ApplicationSystemTestCase
  setup do
    @caso = casos(:one)
    crear_y_entrar_como_usuario_system_test('user','user12345',false)
  end

  test "visiting the index" do
    visit casos_url
    assert_selector "h1", text: "Casos"
  end

  test "creating a Caso" do
    visit casos_url
    click_on "Nuevo Caso"
    fill_in with: "Texto de Prueba", id: "caso_texto_caso"
    click_on "Crear Caso"
    assert_text "El caso fue creado exitosamente"
  end

  test "updating a Caso" do
    visit casos_url
    click_on "Editar", match: :first
    fill_in with: "Texto de Prueba de Actualizacion", id: "caso_texto_caso"
    click_on "Actualizar Caso"
    assert_text "El caso fue actualizado exitosamente"
  end

  test "solo admin puede borrar casos" do
    visit casos_url
    assert_no_button "Eliminar"
    click_button "Terminar Sesion"
    crear_y_entrar_como_usuario_system_test('user_admin','user12345',true)
    visit casos_url
    assert_button "Eliminar"
    click_on "Eliminar", match: :first
    assert_text "El caso fue eliminado exitosamente"
  end

  test "enviar caso a archivo del cliente"do 
    visit casos_url
    click_button "Hecho", match: :first
    assert_text "El caso fue actualizado exitosamente"
  end
end
