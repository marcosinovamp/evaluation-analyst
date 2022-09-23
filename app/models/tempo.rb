class Tempo < ApplicationRecord
    has_many :avaliacos
    has_many :derivados

    def self.cronos
        @cronos_memo ||= Tempo.all.sort_by{|t| t.data}
    end

    def fotografia_geral
        @fgtotal = 0
        @fgpositivas = 0
        @fgnegativas = 0
        self.avaliacos.pluck(:total, :positivas, :negativas).each do |a|
            @fgtotal += a[0]
            @fgpositivas += a[1]
            @fgnegativas += a[2]
        end
        return [@fgtotal, @fgpositivas, @fgnegativas]
    end

    def aprovacao_media
        self.fotografia_geral[1].to_f/(self.fotografia_geral[0] == 0 ? 1 : self.fotografia_geral[0])
    end

    def fotografia_periodo
        @fptotal = 0
        @fppositivas = 0
        @fpnegativas = 0
        self.avaliacos.pluck(:tot_periodo, :pos_periodo, :neg_periodo).each do |a|
            @fptotal += a[0]
            @fppositivas += a[1]
            @fpnegativas += a[2]
        end
        return [@fptotal, @fppositivas, @fpnegativas]
    end

    def aprovacao_periodo
        self.fotografia_periodo[1].to_f/(self.fotografia_periodo[0] == 0 ? 1 : self.fotografia_periodo[0])
    end

end


