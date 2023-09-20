class DropCasosTable < ActiveRecord::Migration[7.0]
  def change
   drop_table :casos do |t|
      t.belongs_to :cliente, index: true, foreign_key: true
      t.text "texto_caso"
      t.date "fecha_conclusion"
      t.timestamps
   end
  end
end
