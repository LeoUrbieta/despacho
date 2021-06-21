class AddCsdToClientes < ActiveRecord::Migration[6.1]
  def change
    add_column :clientes, :csd, :string 
  end
end
