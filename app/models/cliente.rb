class Cliente < ApplicationRecord
  require 'csv'
 
  validates :razon_social, presence: true
  validates :rfc, presence: true, uniqueness: true
  validates :num_interno, presence: true, uniqueness: true, allow_nil: true 
  has_many :casos
  has_and_belongs_to_many :replegales

  def self.to_csv
    attributes = %w{num_interno razon_social clave fiel csd}

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

end
