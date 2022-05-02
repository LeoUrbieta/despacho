class UsuarioExterno < ApplicationRecord
  before_create :confirmation_token

  has_secure_password

  validates :nombre_usuario, presence: true, uniqueness: true 
  validates :password, length: { minimum: 8}


  def activar_email
    self.email_confirmado = true
    self.confirm_token = nil
    save!(:validate => false)
  end
  
  private

  def confirmation_token
    if self.confirm_token.blank?
      self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
  end
end
