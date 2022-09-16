class Servico < ApplicationRecord
    has_many :avaliacos
    belongs_to :orgao

    def datas
        @data = []
        self.avaliacos.each do |a|
            if @data.include?(a.data.to_date) == false
                @data << a.data.to_date
            end
        end
        @data = @data.sort
    end

    def last
        @last = self.avaliacos.sort_by{|a| a.data}.last
    end
    
    def total
        self.last.positivas + self.last.negativas
    end

    def aprovacao
        self.last.positivas.to_f/self.total
    end

    def pos_periodo
        self.avaliacos.sort_by{|a|a.data}.last.positivas -  self.avaliacos.sort_by{|a|a.data}[-2].positivas
    end

    def neg_periodo
        self.avaliacos.sort_by{|a|a.data}.last.negativas -  self.avaliacos.sort_by{|a|a.data}[-2].negativas
    end

    def tot_periodo
        self.pos_periodo + self.neg_periodo
    end

end
