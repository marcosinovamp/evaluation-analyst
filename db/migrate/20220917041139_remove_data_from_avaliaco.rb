class RemoveDataFromAvaliaco < ActiveRecord::Migration[7.0]
  def change
    remove_column :avaliacos, :data
  end
end
