class AddNomeFantasiaToOrgao < ActiveRecord::Migration[7.0]
  def change
    add_column :orgaos, :nome_fantasia, :string
  end
end
