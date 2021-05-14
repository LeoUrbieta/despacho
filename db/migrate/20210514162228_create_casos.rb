class CreateCasos < ActiveRecord::Migration[6.1]
  def change
    create_table :casos do |t|
      t.belongs_to :cliente, index: true, foreign_key: true
      t.text "texto_caso"
      t.timestamps
    end
  end
end
