class AddFolioToPeticiones < ActiveRecord::Migration[6.1]
  def change
    add_column :peticiones, :folio, :integer
  end
end
