class AddStatusToServico < ActiveRecord::Migration[7.0]
  def change
    add_column :servicos, :status, :string
  end
end
