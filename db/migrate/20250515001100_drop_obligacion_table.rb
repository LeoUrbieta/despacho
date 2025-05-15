class DropObligacionTable < ActiveRecord::Migration[8.0]
  def change
    drop_table :obligaciones
  end
end
