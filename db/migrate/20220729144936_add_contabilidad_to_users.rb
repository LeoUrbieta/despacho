class AddContabilidadToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :contabilidad, :boolean, default: false
  end
end
