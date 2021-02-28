class Peticion < ApplicationRecord
  validates :nombre_trabajador, :apellido_paterno, :apellido_materno, :movimiento,
  :empresa_solicitante, :persona_solicitante, presence: true

  default_scope -> { order(id: :desc)}

end
