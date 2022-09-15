class AddServicoToAvaliaco < ActiveRecord::Migration[7.0]
  def change
    add_reference :avaliacos, :servico
  end
end
