class AddNoPresentarToClientes < ActiveRecord::Migration[7.0]
  def change
    add_column :clientes, :presentar_contabilidad, :boolean
  end
end
