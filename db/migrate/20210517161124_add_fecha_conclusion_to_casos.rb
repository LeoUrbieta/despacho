class AddFechaConclusionToCasos < ActiveRecord::Migration[6.1]
  def change
    add_column :casos, :fecha_conclusion, :date 
  end
end
