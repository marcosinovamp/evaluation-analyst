class AddAprovacaoAndTotaltoAvaliacos < ActiveRecord::Migration[7.0]
  def change
    add_column :avaliacos, :total, :integer
    add_column :avaliacos, :aprov, :float
  end
end
