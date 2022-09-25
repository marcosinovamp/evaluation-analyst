class AddSiorgToOrgao < ActiveRecord::Migration[7.0]
  def change
    add_column :orgaos, :siorg, :integer
  end
end
