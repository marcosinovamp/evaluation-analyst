class Orgao < ApplicationRecord
    has_many :servicos
    has_many :avaliacos, through: :servicos
    has_many :tempos, through: :avaliacos
    has_many :derivados

    def novos
        self.servicos.where(status: "Novo")
    end

    def retirados
        self.servicos.where(status: "Retirado")
    end

    def mantidos
        self.servicos.where(status: "Mantido")
    end

    def atuais
        self.servicos.select{|s| s.status=="Novo" || s.status=="Mantido"}
    end

    def fotografia_geral
        @total = 0
        @positivas = 0
        @negativas = 0
        self.avaliacos.select{|av| av.tempo_id == Tempo.cronos.last.id && av.atual?}.pluck(:total, :positivas, :negativas).each do |a|
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
        self.avaliacos.select{|av| av.tempo_id == Tempo.cronos.last.id && av.atual?}.pluck(:tot_periodo, :pos_periodo, :neg_periodo).each do |a|
            @total_per += (a[0].nil? ? 0 : a[0])
            @positivas_per += (a[1].nil? ? 0 : a[1])
            @negativas_per += (a[2].nil? ? 0 : a[2])
        end
        return [@total_per, @positivas_per, @negativas_per]
    end

    def aprovacao_periodo
        self.fotografia_periodo[1].to_f/(self.fotografia_periodo[0] == 0 ? 1 : self.fotografia_periodo[0])
    end

    def aprovacao_antiga(data_id)
        @pos = 0
        @tot = 0
        self.avaliacos.select{|a| a.tempo_id == data_id}.pluck(:positivas, :total, :tempo_id).each do |av|
            @pos += av[0]
            @tot += av[1]
        end
        @aval = @pos.to_f/(@tot == 0 ? 1 : @tot)
        return @aval
    end

    def participacao_media
        @soma = 0
        self.derivados.select{|dev| dev.tempo_id == Tempo.cronos.last.id && dev.atual?}.pluck(:participacao).each do |d|
            @soma += d.to_f
        end
        return @soma
    end

    def participacao_periodo
        @soma = 0
        self.derivados.select{|dev| dev.tempo_id == Tempo.cronos.last.id && dev.atual?}.pluck(:part_periodo).each do |d|
            @soma += d
        end
        return @soma.to_f
    end

    def impacto_medio
        @soma = 0
        self.derivados.select{|dev| dev.tempo_id == Tempo.cronos.last.id && dev.atual?}.pluck(:impacto).each do |d|
            @soma += d.to_f
        end
        return @soma
    end

    def impacto_periodo
        @soma = 0
        self.derivados.select{|dev| dev.tempo_id == Tempo.cronos.last.id && dev.atual?}.pluck(:imp_periodo).each do |d|
            @soma += d.to_f
        end
        return @soma
    end

    def self.mais10
        self.all.select{|o| o.fotografia_periodo[0] > 9}
    end

    def self.mais100
        self.all.select{|o| o.fotografia_periodo[0] > 99}
    end

    def self.mais1000
        self.all.select{|o| o.fotografia_geral[0] > 999}
    end

    def var_aprovacao_media
        self.aprovacao_media - self.aprovacao_antiga(Tempo.cronos[-2].id)
    end

    def outperformance
        self.aprovacao_periodo - self.aprovacao_antiga(Tempo.cronos[-2].id)
    end

end