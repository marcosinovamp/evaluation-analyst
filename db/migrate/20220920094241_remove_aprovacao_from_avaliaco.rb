class RemoveAprovacaoFromAvaliaco < ActiveRecord::Migration[7.0]
  def change
    remove_column :avaliacos, :aprov
    remove_column :avaliacos, :apv_periodo
  end
end
