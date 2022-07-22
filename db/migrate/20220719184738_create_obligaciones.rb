class CreateObligaciones < ActiveRecord::Migration[7.0]
  def change
    create_table :obligaciones do |t|
      t.datetime :fecha
      t.string :presentadas, array: true
      t.belongs_to :cliente, foreign_key: true

      t.timestamps
    end
  end
end
