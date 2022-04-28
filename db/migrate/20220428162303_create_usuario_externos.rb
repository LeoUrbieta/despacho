class CreateUsuarioExternos < ActiveRecord::Migration[7.0]
  def change
    create_table :usuario_externos do |t|
      t.string :nombre_usuario_externo
      t.string :password_digest

      t.timestamps
    end
  end
end
