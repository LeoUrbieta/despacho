class Cliente < ApplicationRecord
  require 'csv'
 
  validates :razon_social, presence: true
  validates :rfc, presence: true, uniqueness: true
  validates :num_interno, presence: true, uniqueness: true, allow_nil: true 
  has_many :casos

  def self.to_csv
    attributes = %w{num_interno razon_social clave fiel csd}

    CSV.generate(headers: true, col_sep: ",") do |csv|
      csv << attributes

      all.each do |cliente|
        csv << attributes.map{ |attr| cliente.send(attr)  }
      end
    end
  end
end
