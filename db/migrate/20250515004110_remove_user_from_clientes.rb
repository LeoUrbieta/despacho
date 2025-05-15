class RemoveUserFromClientes < ActiveRecord::Migration[8.0]
  def change
    remove_reference :clientes, :user, null: false, foreign_key: true
  end
end
