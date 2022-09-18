class AddColumnsToAvaliaco < ActiveRecord::Migration[7.0]
  def change
    add_column :avaliacos, :pos_periodo, :integer
    add_column :avaliacos, :neg_periodo, :integer
    add_column :avaliacos, :tot_periodo, :integer
    add_column :avaliacos, :apv_periodo, :float
  end
end
