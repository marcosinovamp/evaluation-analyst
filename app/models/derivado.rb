class Derivado < ApplicationRecord
    belongs_to :avaliaco
    belongs_to :servico
    belongs_to :orgao
    belongs_to :tempo

    def atual?
        if Servico.find(self.servico_id).status == "Novo" || Servico.find(self.servico_id).status == "Mantido"
            return true
        else
            return false
        end
    end

end