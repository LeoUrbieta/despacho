class RemovePresentadasFromObligaciones < ActiveRecord::Migration[7.0]
  def up
    remove_column :obligaciones, :presentadas, :string
  end
  def down
    add_column :obligaciones, :presentadas, :string, array: true
  end
end
