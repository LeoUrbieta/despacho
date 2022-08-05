class ChangeRegimenFiscalToArray < ActiveRecord::Migration[7.0]
  def change
    remove_column :clientes, :regimen_fiscal, :string
    add_column :clientes, :regimen_fiscal, :string, array: true
  end
end
