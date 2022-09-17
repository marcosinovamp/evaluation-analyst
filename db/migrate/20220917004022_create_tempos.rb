class CreateTempos < ActiveRecord::Migration[7.0]
  def change
    create_table :tempos do |t|
      t.date :data

      t.timestamps
    end
  end
end
