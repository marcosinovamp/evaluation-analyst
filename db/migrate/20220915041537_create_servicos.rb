class CreateServicos < ActiveRecord::Migration[7.0]
  def change
    create_table :servicos do |t|
      t.integer :api_id
      t.string :nome
      t.string :orgao

      t.timestamps
    end
  end
end
