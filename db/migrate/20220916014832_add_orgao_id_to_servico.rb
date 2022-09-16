class AddOrgaoIdToServico < ActiveRecord::Migration[7.0]
  def change
    add_reference :servicos, :orgao
  end
end
