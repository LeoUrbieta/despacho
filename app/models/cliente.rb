class Cliente < ApplicationRecord
  validates :razon_social, :rfc, :num_interno, presence: true 
  validates :num_interno, uniqueness: true 
  has_many :casos
end
