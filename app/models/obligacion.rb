class Obligacion < ApplicationRecord

  belongs_to :cliente

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

end
