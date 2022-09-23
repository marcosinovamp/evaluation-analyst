class Orgao < ApplicationRecord
    has_many :servicos
    has_many :avaliacos, through: :servicos
    has_many :tempos, through: :avaliacos
    has_many :derivados

    def novos
        self.servicos.where(status: "Novo").size
    end

    def retirados
        self.servicos.where(status: "Retirado").size
    end

    def mantidos
        self.servicos.where(status: "Mantido").size
    end

    def atuais
        self.servicos.all.select{|s| s.status="Novo" || s.status="Mantido"}.size
    end

    def fotografia_geral
        @total = 0
        @positivas = 0
        @negativas = 0
        self.avaliacos.select{|av| av.tempo_id == Tempo.cronos.last.id}.pluck(:total, :positivas, :negativas).each do |a|
            @total += (a[0].nil? ? 0 : a[0])
            @positivas += (a[1].nil? ? 0 : a[1])
            @negativas += (a[2].nil? ? 0 : a[2])
        end
        return [@total, @positivas, @negativas]
    end

    def aprovacao_media
        self.fotografia_geral[1].to_f/(self.fotografia_geral[0] == 0 ? 1 : self.fotografia_geral[0])
    end

    def fotografia_periodo
        @total_per = 0
        @positivas_per = 0
        @negativas_per = 0
        self.avaliacos.select{|av| av.tempo_id == Tempo.cronos.last.id}.pluck(:tot_periodo, :pos_periodo, :neg_periodo).each do |a|
            @total_per += (a[0].nil? ? 0 : a[0])
            @positivas_per += (a[1].nil? ? 0 : a[1])
            @negativas_per += (a[2].nil? ? 0 : a[2])
        end
        return [@total_per, @positivas_per, @negativas_per]
    end

    def aprovacao_periodo
        self.fotografia_periodo[1].to_f/(self.fotografia_periodo[0] == 0 ? 1 : self.fotografia_periodo[0])
    end

    def participacao_media
        @soma = 0
        self.derivados.select{|dev| dev.tempo_id == Tempo.cronos.last.id}.pluck(:participacao).each do |d|
            @soma += d.to_f
        end
        return @soma
    end

    def participacao_periodo
        @soma = 0
        self.derivados.select{|dev| dev.tempo_id == Tempo.cronos.last.id}.pluck(:part_periodo).each do |d|
            @soma += d
        end
        return @soma.to_f
    end

    def impacto_medio
        @soma = 0
        self.derivados.select{|dev| dev.tempo_id == Tempo.cronos.last.id}.pluck(:impacto).each do |d|
            @soma += d.to_f
        end
        return @soma
    end

    def impacto_periodo
        @soma = 0
        self.derivados.select{|dev| dev.tempo_id == Tempo.cronos.last.id}.pluck(:imp_periodo).each do |d|
            @soma += d.to_f
        end
        return @soma
    end

end