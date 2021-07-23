class Caso < ApplicationRecord
  audited
  validates :cliente_id, :texto_caso, presence: true
  
  belongs_to :cliente

  default_scope -> { order(id: :desc)}

end
