class Peticion < ApplicationRecord
  validates :nombre_trabajador, :apellido_paterno, :apellido_materno, presence: true
end
