class Replegal < ApplicationRecord
  audited
  validates :nombre_completo, :rfc, presence: true, uniqueness: true
  has_and_belongs_to_many :clientes,
    before_add: :checar_id_no_este_ya_asignado


  def checar_id_no_este_ya_asignado(cliente)
    unless cliente.replegales.empty?
      if cliente.replegales.first.id != self.id
        errors.add(:base, cliente.razon_social +
                   " ya tiene asignado al representante legal " +
                   cliente.replegales.find(cliente.replegales.first.id).
                   nombre_completo)
        throw(:abort)
      end
    end
  end

  def self.agregar_clientes(params, replegal)
    clientes_asociados_previamente = replegal&.cliente_ids
    clientes_por_agregar = Array.new()

    # Borrar primera entrada que siempre viene como String ""
    params[:cliente_ids].delete_if { |x| x == "" }

    #######
    # Este bloque es si venimos de un update request y el Replegal esta ya asociado a una persona fisica
    # de la lista de clientes. Tenemos que agregar su id para que se mantenga la asociacion
    # entre el Replegal y dicho cliente persona física.
    if replegal
      persona_fisica_en_clientes_asociada = replegal.clientes.where("(num_interno is null AND LENGTH(rfc) = 13) OR CAST(num_interno AS integer) < CAST(600 AS integer)").first
      if persona_fisica_en_clientes_asociada
        params[:cliente_ids].insert(0, persona_fisica_en_clientes_asociada.id.to_s)
      end
    end

    ######

    if params[:cliente_ids].size() >= 1
      if params["cliente_ids"].one? { |id| Cliente.find(id).num_interno.to_i < 600 }
        cliente_asociado_no_tiene_replegales = obtener_clave_fiel_csd(params)
        if cliente_asociado_no_tiene_replegales
          if replegal
            clientes_por_agregar.push(replegal.clientes.first.id)
          end
        end
      elsif not params[:cliente_ids].none? { |id| Cliente.find(id).num_interno.to_i < 600 }
        if not replegal
          replegal = Replegal.new()
        end
        replegal.errors.add(:base, "Un representante legal solo puede estar asociado
                             a una persona física")
        return false, replegal, params
      end
      for id_cliente in 0..params[:cliente_ids].size()-1
        clientes_por_agregar.push(params[:cliente_ids][id_cliente])
      end
    end
    if not replegal
      replegal = Replegal.new(params)
    end
    if not clientes_por_agregar.empty?
      # Tiene que ser replegal.cliente_ids ya que es de esta manera que el
      # metodo checar_id_no_este_ya_asignado pueda ser llamado. Si hacemos
      # replegal.update() este método no es llamado
      replegal.cliente_ids=clientes_por_agregar
    end
    if replegal.errors.any?
      if clientes_asociados_previamente
        replegal.cliente_ids=clientes_asociados_previamente
      end
      return false, replegal, params
    end
    return true, replegal, params
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
    cliente_por_asociar.replegales.empty?
  end
end
