class Cliente < ApplicationRecord
  validates :razon_social, :rfc, presence: true
  validates :num_interno, presence: true, uniqueness: true, allow_nil: true 
  has_many :casos
end
