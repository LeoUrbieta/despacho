class Cliente < ApplicationRecord
  validates :razon_social, :rfc, :num_interno, presence: true 
  
  has_many :casos
end
