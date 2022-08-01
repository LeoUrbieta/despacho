class Obligacion < ApplicationRecord

  belongs_to :cliente

  validates :fecha, presence: true
  validates_uniqueness_of :fecha, scope: :cliente_id

  default_scope -> { order(fecha: :desc)}

  def self.isr(num_interno)
    if num_interno < 600
      [
        {'Act. Empresarial y Profesional' => 'Act. Empresarial y Profesional'},
        {'Arrendamiento'=>'Arrendamiento'},
        {'RESICO'=>'RESICO'}
      ]
    else
      [
        {'Regimen General de Ley' => 'Regimen General de Ley'},
        {'RESICO'=>'RESICO'}
      ]
    end
  end


  def self.retenciones(num_interno)
    if num_interno < 600
      [
        {'ISR Salarios'=>'ISR Salarios'},
        {'ISR Asimilados a Salarios' => 'ISR Asimilados a Salarios'}
      ]
    else
      [
        {'ISR Salarios'=>'ISR Salarios'},
        {'ISR Asimilados a Salarios' => 'ISR Asimilados a Salarios'},
        {'Arrendamiento' => 'Arrendamiento'},
        {'Honorarios' => 'Honorarios'},
        {'IVA'=> 'IVA'}
      ]
    end
  end

  def self.iva
    [
      {'IVA General' => 'IVA General'},
      {'IVA RESICO' => 'IVA RESICO'},
      {'DIOT' => 'DIOT'}
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
