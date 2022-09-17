class Tempo < ApplicationRecord
    has_many :avaliacos

# CLASS METHODS
    def self.cronos
        Tempo.all.sort_by{|t| t.data}
    end
# END OF CLASS METHODS
# OBJECT METHODS

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
        self.positivas/(self.total == 0 ? 1 : self.total)
    end

# END OF OBJECT METHODS
end
