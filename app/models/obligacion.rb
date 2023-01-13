class Obligacion < ApplicationRecord

  belongs_to :cliente

  validates :fecha, presence: true, uniqueness: {scope: :cliente_id}

  default_scope -> { order(fecha: :desc)}

end
