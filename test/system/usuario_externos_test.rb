require "application_system_test_case"

class UsuarioExternosTest < ApplicationSystemTestCase
  setup do
    @usuario_externo = usuario_externos(:one)
  end

  test "visiting the index" do
    visit usuario_externos_url
    assert_selector "h1", text: "Usuario externos"
  end

  test "should create usuario externo" do
    visit usuario_externos_url
    click_on "New usuario externo"

    fill_in "Nombre usuario", with: @usuario_externo.nombre_usuario
    click_on "Create Usuario externo"

    assert_text "Usuario externo was successfully created"
    click_on "Back"
  end

  test "should update Usuario externo" do
    visit usuario_externo_url(@usuario_externo)
    click_on "Edit this usuario externo", match: :first

    fill_in "Nombre usuario", with: @usuario_externo.nombre_usuario
    click_on "Update Usuario externo"

    assert_text "Usuario externo was successfully updated"
    click_on "Back"
  end

  test "should destroy Usuario externo" do
    visit usuario_externo_url(@usuario_externo)
    click_on "Destroy this usuario externo", match: :first

    assert_text "Usuario externo was successfully destroyed"
  end
end
