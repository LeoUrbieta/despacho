class Replegal < ApplicationRecord
  audited
  validates :nombre_completo, :rfc, presence: true, uniqueness: true
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

  def self.agregar_clientes(params,replegal)
    clientes_por_agregar = Array.new()
    params[:cliente_ids].delete_if {|x| x == ""}
    if params[:cliente_ids].size() >= 1 
      if params["cliente_ids"].one? { |id| Cliente.find(id).num_interno.to_i < 600}
        cliente_asociado_no_tiene_replegales = obtener_clave_fiel_csd(params)
        if not cliente_asociado_no_tiene_replegales
          if replegal
            clientes_por_agregar.push(replegal.clientes.first.id)
          end
        end
      elsif not params[:cliente_ids].none? { |id| Cliente.find(id).num_interno.to_i < 600}
        if not replegal
          replegal = Replegal.new()
        end
        replegal.errors.add(:base,"Un representante legal solo puede estar asociado
                             a una persona física")
        return false,replegal,params
      end
      for id_cliente in 0..params[:cliente_ids].size()-1
        clientes_por_agregar.push(params[:cliente_ids][id_cliente])
      end
    end
    if not replegal 
      replegal = Replegal.new(params) 
    end
    if not clientes_por_agregar.empty?
      replegal.cliente_ids=clientes_por_agregar
    end
    if replegal.errors.any?
      return false,replegal,params
    end
    return true,replegal,params
  end

  private
  
  def self.obtener_clave_fiel_csd(params)
      indice_persona_fisica = params["cliente_ids"].
        index { |id| Cliente.find(id.to_i).num_interno.to_i < 600 }
      cliente_por_asociar = Cliente.find(params["cliente_ids"][indice_persona_fisica])
      if cliente_por_asociar.replegales.empty?
        params["nombre_completo"] = cliente_por_asociar.razon_social
        params["clave"] = cliente_por_asociar.clave
        params["rfc"] = cliente_por_asociar.rfc
        params["fiel"] = cliente_por_asociar.fiel
        params["csd"] = cliente_por_asociar.csd 
        params["vencimiento_fiel(1i)"]= cliente_por_asociar.fiel_vencimiento.year.to_s
        params["vencimiento_fiel(2i)"] = cliente_por_asociar.fiel_vencimiento.month.to_s
        params["vencimiento_fiel(3i)"] = cliente_por_asociar.fiel_vencimiento.day.to_s
        params["vencimiento_csd(1i)"]= cliente_por_asociar.csd_vencimiento.year.to_s
        params["vencimiento_csd(2i)"]= cliente_por_asociar.csd_vencimiento.month.to_s
        params["vencimiento_csd(3i)"]= cliente_por_asociar.csd_vencimiento.day.to_s
      end
      return cliente_por_asociar.replegales.empty? 
    end
end
