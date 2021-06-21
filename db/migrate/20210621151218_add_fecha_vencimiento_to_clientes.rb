class AddFechaVencimientoToClientes < ActiveRecord::Migration[6.1]
  def change
    add_column :clientes, :fiel_vencimiento, :date, default: 1.year.from_now.to_date
    add_column :clientes, :csd_vencimiento, :date, default: 1.year.from_now.to_date
  end
end
