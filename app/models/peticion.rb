class Peticion < ApplicationRecord
  validates :nombre_trabajador, :apellido_paterno, :apellido_materno, :movimiento,
  :empresa_solicitante, :persona_solicitante, :usuario_externo_id, presence: true

  default_scope -> { order(id: :desc) }

  belongs_to :usuario_externo

  has_one_attached :respuesta_idse
end
