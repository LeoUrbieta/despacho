class Obligacion < ApplicationRecord

  belongs_to :cliente

  validates :fecha, presence: true, uniqueness: true

  default_scope -> { order(fecha: :desc)}

  def self.lista_obligaciones 
    [
     {'IVA' => "IVA mes"},
     {'ISR' => 'ISR mes'},
     {'DIOT' => 'DIOT mes'},
     {'ISR Retenciones Sueldos y Salarios' => 'ISR Retenciones Sueldos y Salarios'},
     {'ISR Arrendamiento' => 'ISR Arrendamiento'},
     {'IVA Retenciones' => 'IVA Retenciones'},
     {'ISR Retenciones Asimilados a Salarios' => 'ISR Retenciones Asimilados a Salarios'}
    ]
  end

  def self.declaracion_presentada?(valor,obligacion)
    # El valor &.include? evita que se ejecuta si la variable es nil.
    # Muy util.
    if obligacion.presentadas&.include? valor 
      return true
    else
      return false
    end
  end
end
