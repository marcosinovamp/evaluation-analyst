class Avaliaco < ApplicationRecord
    belongs_to :tempo
    belongs_to :servico
    has_one :orgao, through: :servico
    has_one :derivado

    def atual?
        return self.atual
    end

end
