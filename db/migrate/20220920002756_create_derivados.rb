class CreateDerivados < ActiveRecord::Migration[7.0]
  def change
    create_table :derivados do |t|
      t.float :aprovacao
      t.float :participacao
      t.float :impacto
      t.float :aprov_periodo
      t.float :part_periodo
      t.float :imp_periodo

      t.timestamps
    end
  end
end
