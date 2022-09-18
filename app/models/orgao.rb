class Orgao < ApplicationRecord
    has_many :servicos
    has_many :avaliacos, through: :servicos
    has_many :tempos, through: :avaliacos

    def self.total
        Orgao.all.size
    end

    def novos_serv
        self.servicos.select{|s| s.status=="Novo"}.size
    end

    def mantidos_serv
        self.servicos.select{|s| s.status=="Mantido"}.size
    end

    def retirados_serv
        self.servicos.select{|s| s.status=="Retirado"}.size
    end

    def qtd_atual
        self.novos_serv + self.mantidos_serv
    end

    def positivas
        @soma = 0
        self.servicos.each do |s|
            s.avaliacos.select{|av| av.tempo.data == Tempo.cronos.last.data.to_date}.each do |a|
                @soma += a.positivas
            end
        end
        return @soma
    end

    def negativas
        @soma = 0
        self.servicos.each do |s|
            s.avaliacos.select{|av| av.tempo.data == Tempo.cronos.last.data.to_date}.each do |a|
                @soma += a.negativas
            end
        end
        return @soma
    end

    def total
        @soma = 0
        self.servicos.each do |s|
            s.avaliacos.select{|av| av.tempo.data == Tempo.cronos.last.data.to_date}.each do |a|
                @soma += a.total
            end
        end
        return @soma
    end

    def pos_periodo
        @soma = 0
        self.servicos.each do |s|
            s.avaliacos.select{|av| av.tempo.data == Tempo.cronos.last.data.to_date}.each do |a|
                @soma += a.pos_periodo
            end
        end
        return @soma
    end

    def neg_periodo
        @soma = 0
        self.servicos.each do |s|
            s.avaliacos.select{|av| av.tempo.data == Tempo.cronos.last.data.to_date}.each do |a|
                @soma += a.neg_periodo
            end
        end
        return @soma
    end

    def tot_periodo
        @soma = 0
        self.servicos.each do |s|
            s.avaliacos.select{|av| av.tempo.data == Tempo.cronos.last.data.to_date}.each do |a|
                @soma += a.tot_periodo
            end
        end
        return @soma
    end
    

end