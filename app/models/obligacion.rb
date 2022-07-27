class Obligacion < ApplicationRecord

  belongs_to :cliente

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
