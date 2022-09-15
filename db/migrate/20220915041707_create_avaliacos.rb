class CreateAvaliacos < ActiveRecord::Migration[7.0]
  def change
    create_table :avaliacos do |t|
      t.datetime :data
      t.integer :positivas
      t.integer :negativas

      t.timestamps
    end
  end
end
