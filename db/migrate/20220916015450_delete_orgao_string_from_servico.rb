class DeleteOrgaoStringFromServico < ActiveRecord::Migration[7.0]
  def change
    remove_column :servicos, :orgao
  end
end
