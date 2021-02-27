class Peticion < ApplicationRecord
  validates :nombre_trabajador, :apellido_paterno, :apellido_materno, :movimiento,
  :empresa_solicitante, :persona_solicitante, :rfc, presence: true
end
