class CreateUsuarioExternos < ActiveRecord::Migration[7.0]
  def change
    create_table :usuario_externos do |t|
      t.string :nombre_usuario

      t.timestamps
    end
  end
end
