class AddFielToClientes < ActiveRecord::Migration[6.1]
  def change
    add_column :clientes, :fiel, :string
  end
end
