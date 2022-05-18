require "test_helper"

class PeticionMailerTest < ActionMailer::TestCase

  setup do
    @peticion_con_respuesta_idse = peticiones(:two)
  end

  test "enviar correo confirmacion" do
    @usuario_externo = UsuarioExterno.new(nombre_usuario: "example@example.com", password: "password")
    if @usuario_externo.save
      mail = PeticionMailer.with(usuario_externo: @usuario_externo).welcome_email
      assert_no_emails
      assert_emails 1 do
        mail.deliver_now
      end
      assert_equal [Rails.application.credentials.dig(:gmail, :user)], mail.from
      assert_equal ["example@example.com"], mail.to
      assert_includes mail.body.to_s, Rails.application.credentials.dig(:production,:host)
    end
  end

  test "enviar documento idse al adjuntarlo a la peticion" do
    if @peticion_con_respuesta_idse.respuesta_idse.attached? 
      mail = PeticionMailer.with(peticion: @peticion_con_respuesta_idse).enviar_respuesta_idse
      assert_no_emails
      assert_emails 1 do
        mail.deliver_now
      end
      puts mail.body.to_s
      assert_equal [@peticion_con_respuesta_idse.usuario_externo.nombre_usuario], mail.to
      assert_includes mail.subject, "Documento IDSE"
    end
  end
end
