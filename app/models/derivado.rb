class Derivado < ApplicationRecord
    belongs_to :avaliaco
    belongs_to :servico
    belongs_to :orgao
    belongs_to :tempo

    def atual?
        return self.atual
    end

end