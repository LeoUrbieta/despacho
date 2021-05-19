class AddClaveToClientes < ActiveRecord::Migration[6.1]
  def change
    add_column :clientes, :clave, :string
  end
end
