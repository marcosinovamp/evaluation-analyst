class Avaliaco < ApplicationRecord
    belongs_to :tempo
    belongs_to :servico
    has_one :orgao, through: :servico
    has_one :derivado

    def atual?
        if Servico.find(self.servico_id).status == "Novo" || Servico.find(self.servico_id).status == "Mantido"
            return true
        else
            return false
        end
    end
    
end
