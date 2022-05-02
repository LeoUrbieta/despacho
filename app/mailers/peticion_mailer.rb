class PeticionMailer < ApplicationMailer
  default from: 'mfiscalistas@gmail.com'

  def welcome_email
    @user = params[:usuario_externo]
    @url  = 'https://asesoresmf.herokuapp.com'
    mail(to: @user.nombre_usuario, subject: 'Correo de Verificación')
  end
end
