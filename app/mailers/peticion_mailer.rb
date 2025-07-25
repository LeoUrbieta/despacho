class PeticionMailer < ApplicationMailer
  default from: Rails.application.credentials.dig(:mailbox, :user)

  def welcome_email
    @user = params[:usuario_externo]
    mail(to: @user.nombre_usuario, subject: "Correo de Verificación") do |format|
      format.html
    end
  end

  def enviar_respuesta_idse
    peticion = params[:peticion]
    attachments["Respuesta_IDSE.pdf"] = { content: peticion.respuesta_idse.blob.download }
    mail(to: peticion.usuario_externo.nombre_usuario, subject: "Documento IDSE. Peticion #" + peticion.folio.to_s + ". " + peticion.nombre_trabajador + " " + peticion.apellido_paterno + " " + peticion.apellido_materno, reply_to: Rails.application.credentials.dig(:mail,:email))
  end
end
