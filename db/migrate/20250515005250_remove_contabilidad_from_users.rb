class RemoveContabilidadFromUsers < ActiveRecord::Migration[8.0]
  def change
    remove_column :users, :contabilidad, :boolean, default: false
  end
end
