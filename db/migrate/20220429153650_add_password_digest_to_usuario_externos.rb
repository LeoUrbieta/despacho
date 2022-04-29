class AddPasswordDigestToUsuarioExternos < ActiveRecord::Migration[7.0]
  def change
    add_column :usuario_externos, :password_digest, :string
  end
end
