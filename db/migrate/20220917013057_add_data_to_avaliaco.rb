class AddDataToAvaliaco < ActiveRecord::Migration[7.0]
  def change
    add_reference :avaliacos, :tempo
  end
end
