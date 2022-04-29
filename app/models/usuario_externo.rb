class UsuarioExterno < ApplicationRecord
  has_secure_password
  
  validates :nombre_usuario, presence: true
  validates :password_digest, presence: true, length: { minimum: 8}
end
