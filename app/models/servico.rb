class Servico < ApplicationRecord
    has_many :avaliacos
    belongs_to :orgao

    def last
        @last = self.avaliacos.sort_by{|a| a.data}.last
    end
    
    def total
        self.last.positivas + self.last.negativas
    end

    def aprovacao
        self.last.positivas.to_f/self.total
    end

end
