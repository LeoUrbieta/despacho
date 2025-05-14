require "application_system_test_case"

class EnviarPeticionesTest < ApplicationSystemTestCase
  include ActionMailer::TestHelper

  setup do
    User.create!(nombre_usuario: Rails.application.credentials.dig(:usuario_adjuntar_idse, :usuario), password: "password", admin: false, contabilidad: false)
    visit root_path
    fill_in with: Rails.application.credentials.dig(:usuario_adjuntar_idse, :usuario), id: "session_nombre_usuario"
    fill_in with: "password", id: "session_password"
    click_on "Entrar"
    assert_text "Has entrado con éxito"
  end

  test "sin archivo adjunto no se puede enviar" do
    assert_button "Actualizar Peticion"
    first('input[value="Actualizar Peticion"]').click
    assert_text "Tienes que adjuntar un archivo antes"
  end

  test "enviar peticion" do
    assert_button "Actualizar Peticion"
    attach_file "peticion[respuesta_idse]", "./test/fixtures/files/PDF.pdf", match: :first
    assert_emails 1 do
      first('input[value="Actualizar Peticion"]').click
    end
    assert_text "Peticion enviada"
  end
end
