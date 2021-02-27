class ChangePeticionesFecha < ActiveRecord::Migration[6.1]
  def change
    reversible do |dir|
      change_table :peticiones do |t|
        dir.up   {t.change :fecha_nacimiento, :date}
        dir.up   {t.change :fecha_para_realizar_tramite, :date}
        dir.down {t.change :fecha_nacimiento, :string}
        dir.down {t.change :fecha_para_realizar_tramite, :string}
      end
    end
  end
end
