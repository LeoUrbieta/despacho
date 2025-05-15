class RemoveContabilidadFromClientes < ActiveRecord::Migration[8.0]
  def change
    remove_column :clientes, :presentar_contabilidad, :boolean, default: false
  end
end
