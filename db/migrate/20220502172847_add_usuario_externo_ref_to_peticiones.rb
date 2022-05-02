class AddUsuarioExternoRefToPeticiones < ActiveRecord::Migration[7.0]
  def change
    UsuarioExterno.create!(nombre_usuario: "leomoreno@hey.com", password: "password", password_confirmation: "password")
    add_reference :peticiones, :usuario_externo, foreign_key: true
    change_column_null(:peticiones,:usuario_externo_id,false,UsuarioExterno.first.id)
  end
end
