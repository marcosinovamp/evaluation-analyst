class Servico < ApplicationRecord
    belongs_to :orgao
    has_many :avaliacos
    has_many :tempos, through: :avaliacos


   def self.novos
    @novos_memo ||= Servico.all.select{|s| s.status=="Novo"}
    end

    def self.retirados
        @retirados_memo ||= Servico.all.select{|s| s.status=="Retirado"}
    end

    def self.mantidos
        @mantidos_memo ||= Servico.all.select{|s| s.status=="Mantido"}
    end

    def self.atuais
        @atuais_memo ||= Servico.all.select{|s| s.status == "Novo" || s.status == "Mantido"}
    end

    def self.mais_aval_periodo
        @serv_mais_aval_per ||= Servico.all.sort_by{|s| s.avaliacos.select{|a| a.tempo.data == Tempo.cronos.last.data.to_date}.first.tot_periodo*-1}
    end

    def self.mais_pos_periodo
        @serv_mais_aval_per ||= Servico.all.sort_by{|s| s.avaliacos.select{|a| a.tempo.data == Tempo.cronos.last.data.to_date}.first.pos_periodo*-1}
    end

    def self.mais_neg_periodo
        @serv_mais_aval_per ||= Servico.all.sort_by{|s| s.avaliacos.select{|a| a.tempo.data == Tempo.cronos.last.data.to_date}.first.neg_periodo*-1}
    end

    
    def total
        self.avaliacos.select{|a| a.tempo.data == Tempo.cronos.last.data.to_date}.first.total
    end
    
    def positivas
        self.avaliacos.select{|a| a.tempo.data == Tempo.cronos.last.data.to_date}.first.positivas
    end
    
    def negativas
        self.avaliacos.select{|a| a.tempo.data == Tempo.cronos.last.data.to_date}.first.negativas
    end
    
    def aprovacao
        self.positivas.to_f/(self.total == 0 ? 1 : self.total)
    end
    
    def participacao
        self.total/Tempo.cronos.last.total
    end
    
    def self.melhor_avaliados
        @serv_melhor_avaliados ||= Servico.all.select{|s| s.total > 999}.sort_by{|s| s.aprovacao*-1}
    end

end