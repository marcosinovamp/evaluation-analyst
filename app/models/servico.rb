class Servico < ApplicationRecord
    belongs_to :orgao
    has_many :avaliacos
    has_many :tempos, through: :avaliacos
    has_many :derivados

    def self.novos
        self.where(status: "Novo")
    end

    def self.retirados
        self.where(status: "Retirado")
    end

    def self.mantidos
        self.where(status: "Mantido")
    end

    def self.atuais
        self.all.select{|s| s.status == "Novo" || s.status == "Mantido"}
    end

    def self.extintos
        self.where(status: "Extinto")
    end

    def self.aval_novos
        @newtotal = 0
        @newposit = 0
        @newnegat = 0
        self.novos.each do |s|
            s.avaliacos.select{|a| a.tempo_id == Tempo.cronos.last.id}.each do |av|
                @newtotal += av.tot_periodo
                @newposit += av.pos_periodo
                @newnegat += av.neg_periodo
            end
        end
        return [@newtotal, @newposit, @newnegat]
    end

    def self.aval_retirados
        @exctotal = 0
        @excposit = 0
        @excnegat = 0
        self.retirados.each do |s|
            s.avaliacos.select{|a| a.tempo_id == Tempo.cronos[-2].id}.each do |av|
                @exctotal += av.total
                @excposit += av.positivas
                @excnegat += av.negativas
            end
        end
        return [@exctotal, @excposit, @excnegat]
    end

    def self.aval_mantidos
        @kepttotal = 0
        @keptposit = 0
        @keptnegat = 0
        self.mantidos.each do |s|
            s.avaliacos.select{|a| a.tempo_id == Tempo.cronos.last.id}.each do |av|
                @kepttotal += av.tot_periodo
                @keptposit += av.pos_periodo
                @keptnegat += av.neg_periodo
            end
        end
        return [@kepttotal, @keptposit, @keptnegat]
    end

    def qtd_avaliacoes
        self.avaliacos.sort_by{|a| a.tempo.data}.last.total
    end

    def qtd_positivas
        self.avaliacos.sort_by{|a| a.tempo.data}.last.positivas
    end

    def qtd_negativas
        self.avaliacos.sort_by{|a| a.tempo.data}.last.negativas
    end

    def qtd_avaliacoes_periodo
        self.avaliacos.sort_by{|a| a.tempo.data}.last.tot_periodo
    end

    def qtd_positivas_periodo
        self.avaliacos.sort_by{|a| a.tempo.data}.last.pos_periodo
    end

    def qtd_negativas_periodo
        self.avaliacos.sort_by{|a| a.tempo.data}.last.neg_periodo
    end

    def aprovacao_geral
        self.derivados.sort_by{|a| a.tempo.data}.last.aprovacao
    end

    def aprovacao_periodo
        self.derivados.sort_by{|a| a.tempo.data}.last.aprov_periodo
    end

    def self.mais10
        self.all.select{|s| (s.status == "Novo" || s.status == "Mantido") && s.avaliacos.last.tot_periodo > 9}
    end

    def self.mais100
        self.all.select{|s| (s.status == "Novo" || s.status == "Mantido") && s.avaliacos.last.tot_periodo > 99}
    end

    def self.mais1000
        self.all.select{|s| (s.status == "Novo" || s.status == "Mantido") && s.avaliacos.last.total > 999}
    end

    def participacao_geral
        self.derivados.sort_by{|a| a.tempo.data}.last.participacao
    end

    def participacao_periodo
        self.derivados.sort_by{|a| a.tempo.data}.last.part_periodo
    end
    
    def impacto_geral
        self.derivados.sort_by{|a| a.tempo.data}.last.impacto
    end

    def impacto_periodo
        self.derivados.sort_by{|a| a.tempo.data}.last.imp_periodo
    end

end