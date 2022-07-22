class Obligacion < ApplicationRecord

  belongs_to :cliente

  def self.lista_obligaciones 
    [
     {'IVA' => "IVA mes"},
     {'ISR' => 'ISR mes'},
     {'DIOT' => 'DIOT mes'},
    ]
  end

end
