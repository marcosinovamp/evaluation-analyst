class AddReferencesToDerivado < ActiveRecord::Migration[7.0]
  def change
    add_reference :derivados, :avaliaco
    add_reference :derivados, :servico
    add_reference :derivados, :orgao
    add_reference :derivados, :tempo
  end
end
