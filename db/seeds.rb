# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#
require 'csv'

###########################################################################################################################

# CSV.foreach((Rails.root.join('lib','seeds','clientes_total.csv')), headers: true, col_sep: ":") do |row|
#   t = Cliente.new
#   t.razon_social = row['RAZON SOCIAL']
#   t.rfc = row['RFC']
#   t.num_interno = row['NUMERO INTERNO']
#   t.save
#   puts "#{t.razon_social}, se ha guardado"
# end

# puts "Ahora hay #{Cliente.count} clientes en la base de datos"

##########################################################################################################################

#CSV.foreach((Rails.root.join('lib','seeds','claves.csv')), headers: true, col_sep: ":") do |row|
#  cliente_encontrado = Cliente.find_by num_interno: row['NUMERO']
#  if cliente_encontrado != nil
#    cliente_encontrado.clave = row['CIEC']
#    cliente_encontrado.save
#  end
#end

###################################################################################################

CSV.foreach((Rails.root.join('lib','seeds','fiel.csv')), headers: true, col_sep: ":") do |row|
  cliente_encontrado = Cliente.find_by num_interno: row['NUMERO']
  if cliente_encontrado != nil
    cliente_encontrado.fiel = row['CLAVE_FIEL']
    cliente_encontrado.save
  end
end
