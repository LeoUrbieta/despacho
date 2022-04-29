class UsuarioExterno < ApplicationRecord
  has_secure_password

  validates :nombre_usuario, presence: true, uniqueness: true 
  validates :password, length: { minimum: 8}
end
