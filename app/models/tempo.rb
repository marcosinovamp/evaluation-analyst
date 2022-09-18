class Tempo < ApplicationRecord
    has_many :avaliacos

    def self.cronos
        Tempo.all.sort_by{|t| t.data}
    end

    def positivas
        @soma = 0
        self.avaliacos.each do |av|
            @soma += av.positivas
        end
        return @soma
    end

    def negativas
        @soma = 0
        self.avaliacos.each do |av|
            @soma += av.negativas
        end
        return @soma
    end

    def total
        @soma = 0
        self.avaliacos.each do |av|
            @soma += av.total
        end
        return @soma
    end

    def aprovacao
        self.positivas.to_f/(self.total == 0 ? 1 : self.total)
    end

end
