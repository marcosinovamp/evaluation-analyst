class AddOrderToTempo < ActiveRecord::Migration[7.0]
  def change
    add_column :tempos, :order, :integer
  end
end
