class AddColumnasToPeticiones < ActiveRecord::Migration[6.1]
  def change
    add_column :peticiones, :empresa_solicitante, :string
    add_column :peticiones, :persona_solicitante, :string
    add_column :peticiones, :movimiento, :string
    add_column :peticiones, :fecha_nacimiento, :date
    add_column :peticiones, :domicilio, :text
    add_column :peticiones, :numero_imss, :string
    add_column :peticiones, :salario_integrado, :string
    add_column :peticiones, :curp, :string
    add_column :peticiones, :salario_sin_integrar, :string
    add_column :peticiones, :rfc, :string
    add_column :peticiones, :fecha_para_realizar_tramite, :date
    add_column :peticiones, :observaciones, :text
  end
end
