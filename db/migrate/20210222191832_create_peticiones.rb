class CreatePeticiones < ActiveRecord::Migration[6.1]
  def change
    create_table :peticiones do |t|
      t.string :nombre_trabajador
      t.string :apellido_materno
      t.string :apellido_paterno

      t.timestamps
    end
  end
end
