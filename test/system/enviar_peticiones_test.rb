require "application_system_test_case"

class EnviarPeticionesTest < ApplicationSystemTestCase
  setup do
    User.create!(nombre_usuario: Rails.application.credentials.dig(:usuario_adjuntar_idse,:usuario), password: 'password', admin: false)
    visit root_path
    fill_in with: Rails.application.credentials.dig(:usuario_adjuntar_idse,:usuario), id: 'session_nombre_usuario'
    fill_in with: 'password', :id => 'session_password'
    click_on "Entrar"
    assert_text "Has entrado con éxito"
  end

  test "enviar peticion con idse adjunto" do
    assert_button "Actualizar Peticion"
    attach_file "peticion[respuesta_idse]", "./test/fixtures/files/PDF.pdf", match: :first
    click_button "Actualizar Peticion", match: :first

  end
end
