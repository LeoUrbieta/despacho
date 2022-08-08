class Cliente < ApplicationRecord
  audited 
  require 'csv'
 
  validates :razon_social, presence: true
  validates :rfc, presence: true, uniqueness: true
  validates :num_interno, presence: true, uniqueness: true, allow_nil: true 
  has_many :casos, dependent: :restrict_with_error
  has_many :obligaciones, dependent: :restrict_with_error
  has_and_belongs_to_many :replegales
  belongs_to :user, optional: true
  default_scope -> {order(num_interno: :asc)} 

  def self.to_csv
    attributes = %w{num_interno razon_social}

    CSV.generate(headers: true, col_sep: ",") do |csv|
      csv << attributes

      all.each do |cliente|
        csv << attributes.map{ |attr| cliente.send(attr)  }
      end
    end
  end

  def self.obten_numero_interno(tipo_de_persona)
    case tipo_de_persona
    when 'FISICA'
      num_posibles = (301..599).to_a
      num_posibles.each do |num_posible|
        return num_posible if not Cliente.find_by(num_interno: num_posible)
      end
    end
  end

  def self.regimenes_fiscales_fisicas
    [
      {'PFAE'=>'Personas Físicas con Actividades Empresariales y Profesionales'},
      {'RID'=>'Ingresos por Dividendos'},
      {'RESICO PF'=>'Regimen Simplificado de Confianza' },
      {'RARR'=>'Arrendamiento'},
      {'RSSIAS'=>'Sueldos y Salarios e Ingresos Asimilados a Salarios'},
      {'RDI'=>'Demás ingresos'},
      {'RII'=>'Ingresos por intereses'},
      {'AEIP'=>'Actividades Empresariales con ingresos a través de Plataformas tecnológicas'} 
    ]
  end

  def self.regimenes_fiscales_morales
    [
      {'RGLPM'=>'Regimen General de Ley Personas Morales'},
      {'RESICO PM'=>'Regimen Simplificado de Confianza'}
    ]
  end

  def self.tiene_este_regimen_fiscal?(regimen,cliente)
    if cliente.regimen_fiscal&.include? regimen
      return true
    else
      return false
    end
  end
end
