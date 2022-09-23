class AddArtigoToOrgao < ActiveRecord::Migration[7.0]
  def change
    add_column :orgaos, :artigo, :string
  end
end
