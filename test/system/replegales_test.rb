require "application_system_test_case"

class ReplegalesTest < ApplicationSystemTestCase
  setup do
    @replegal = replegales(:one)
    crear_y_entrar_como_usuario_system_test('user_rep_legal','user12345',false)
  end

  test "visiting the index" do
    visit replegales_url
    assert_selector "h1", text: "Representantes Legales"
  end

  test "creating a Replegal" do
    visit replegales_url
    click_on "Nuevo Representante Legal"
    nombre = "MARIANO MATAMOROES"
    fill_in with: nombre, id: 'replegal_nombre_completo'
    fill_in with: "MAMO991011DFA", id: 'replegal_rfc'
    first('input[type="checkbox"]').check
    nombre_empresa = first('label[class="form-check-label"]').text
    click_on "Crear Replegal"
    assert_text "El Representante legal se creó correctamente"
    assert_text nombre
    assert_text nombre_empresa
  end

  test "updating a Replegal" do
    visit replegales_url
    find('.table').find('a',text: replegales(:one).nombre_completo).click
    assert_text replegales(:one).nombre_completo
    assert_link "Editar Rep. Legal"
    click_link "Editar Rep. Legal"
    nombre_nuevo = "JERONIMO AGUILAR"
    fill_in with: nombre_nuevo, id: 'replegal_nombre_completo'
    click_on "Actualizar Replegal"
    assert_text "El representante legal se actualizó correctamente"
    assert_text nombre_nuevo
  end

  test "destroying a Replegal" do
    visit replegales_url
    assert_no_button "Eliminar"
    click_button "Terminar Sesion"
    crear_y_entrar_como_usuario_system_test('user_admin','user12345',true)
    visit replegales_url
    find('.table').find('a',text: replegales(:one).nombre_completo).click
    assert_text replegales(:one).nombre_completo
    assert_button "Eliminar"
    click_button "Eliminar"
    assert_text "El representante legal se eliminó correctamente"
    assert_selector "h1", text: "Representantes Legales"
  end
end
