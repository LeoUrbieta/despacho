class CreateReplegales < ActiveRecord::Migration[6.1]
  def change
    create_table :replegales do |t|
      t.string :nombre_completo
      t.string :rfc
      t.string :clave
      t.string :fiel
      t.string :csd
      t.date   :vencimiento_fiel
      t.date   :vencimiento_clave
      t.date   :vencimiento_csd
      t.timestamps
    end

    create_join_table :replegales, :clientes do |t|
      t.index :replegal_id
      t.index :cliente_id, unique: true
    end
  end
end
