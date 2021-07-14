class Replegal < ApplicationRecord
  validates :nombre_completo, :rfc, presence: true
  has_and_belongs_to_many :clientes,
    before_add: :checar_id_no_este_ya_asignado

  def checar_id_no_este_ya_asignado(cliente)
    unless cliente.replegales.empty?
      errors.add(:base,cliente.razon_social + 
                 " ya tiene asignado al representante legal " + 
                 cliente.replegales.find(cliente.replegal_ids[0]).
                 nombre_completo)  
      throw(:abort)
    end
  end
end
