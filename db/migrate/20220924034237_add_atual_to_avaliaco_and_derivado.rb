class AddAtualToAvaliacoAndDerivado < ActiveRecord::Migration[7.0]
  def change
    add_column :avaliacos, :atual?, :boolean
    add_column :derivados, :atual?, :boolean
  end
end
