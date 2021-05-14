class CreateClientes < ActiveRecord::Migration[6.1]
  def change
    create_table :clientes do |t|
        t.string :razon_social
        t.string :rfc
        t.string :num_interno
        t.string :regimen_fiscal
      t.timestamps
    end
  end
end
