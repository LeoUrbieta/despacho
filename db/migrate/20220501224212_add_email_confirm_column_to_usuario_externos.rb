class AddEmailConfirmColumnToUsuarioExternos < ActiveRecord::Migration[7.0]
  def change
    add_column :usuario_externos, :email_confirmado, :boolean, :default => false
    add_column :usuario_externos, :confirm_token, :string
  end
end
