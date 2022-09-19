class Orgao < ApplicationRecord
    has_many :servicos
    has_many :avaliacos, through: :servicos
    has_many :tempos, through: :avaliacos

    def self.total
        @total_memo ||= Orgao.all..pluck(:id).size
    end

    def novos_serv
        self.servicos.select{|s| s.status=="Novo"}.pluck(:status).size
    end

    def mantidos_serv
        self.servicos.select{|s| s.status=="Mantido"}.pluck(:status).size
    end

    def retirados_serv
        self.servicos.select{|s| s.status=="Retirado"}.pluck(:status).size
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
    
    def aprovacao
        self.positivas.to_f/(self.total == 0 ? 1 : self.total)
    end

    def participacao
        self.total.to_f/Tempo.cronos.last.total
    end

    def impacto
        self.participacao*self.aprovacao - self.participacao*(1-self.aprovacao)
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

    def apv_periodo
        self.pos_periodo.to_f/(self.tot_periodo == 0 ? 1 : self.tot_periodo)
    end

    def part_periodo
        self.tot_periodo.to_f/Tempo.cronos.last.status[:tot_periodo]
    end

    def impacto_periodo
        self.part_periodo*self.apv_periodo - self.part_periodo*(1-self.apv_periodo)
    end

    def self.mais_novos
        @mais_novos_memo ||= @grupo = Orgao.all.sort_by{|o| o.novos_serv*-1}[0..2]
    end

    def self.mais_retirados
        @mais_retirados_memo ||= @grupo = Orgao.all.sort_by{|o| o.retirados_serv*-1}[0..2]
    end

    def self.mais_servicos
        @mais_servicos_memo ||= @grupo = Orgao.all.sort_by{|o| o.qtd_atual*-1}[0..2]
    end

    def self.mais_aval_periodo
        @mais_aval_memo ||= @grupo = Orgao.all.sort_by{|o| o.tot_periodo*-1}
    end
    
    def self.mais_pos_periodo
        @mais_pos_periodo_memo ||= @grupo = Orgao.all.sort_by{|o| o.pos_periodo*-1}
    end

    def self.mais_neg_periodo
        @mais_neg_periodo_memo ||= @grupo = Orgao.all.sort_by{|o| o.neg_periodo*-1}
    end

    def self.mais_imp_per
        @mais_imp_per ||= @grupo = Orgao.all.sort_by{|o| o.impacto_periodo*-1}
    end

    def aprov_anterior
        @ant_pos = 0
        @ant_tot = 0
        self.avaliacos.select{|av| av.tempo.data == Tempo.cronos[-2].data.to_date}.each do |a|
            @ant_pos += a.positivas
            @ant_tot += a.total
        end
        @ant = @ant_pos.to_f/(@ant_tot == 0 ? 1 : @ant_tot)
        return @ant
    end

    def var_aprovacao
       self.aprovacao - self.aprov_anterior
    end

    def self.var_aprovacao
        @var_aprovacao_memo ||= @grupo = Orgao.all.select{|og| og.total > 99}.sort_by{|o| o.var_aprovacao*-1}
    end

    def outperformance
        self.apv_periodo - self.aprov_anterior
    end

    def self.mais_outperf
        @mais_autoperf_memo ||= @grupo = Orgao.all.select{|og| og.total > 99}.sort_by{|o| o.outperformance*-1}
    end


end