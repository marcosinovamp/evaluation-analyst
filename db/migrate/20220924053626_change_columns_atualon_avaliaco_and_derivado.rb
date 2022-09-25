class ChangeColumnsAtualonAvaliacoAndDerivado < ActiveRecord::Migration[7.0]
  def change
    remove_column :avaliacos, :atual?
    add_column :avaliacos, :atual, :boolean
    remove_column :derivados, :atual?
    add_column :derivados, :atual, :boolean
  end
end
