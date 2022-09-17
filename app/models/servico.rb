class Servico < ApplicationRecord
    belongs_to :orgao
    has_many :avaliacos
    has_many :tempos, through: :avaliacos


    def self.novos
        Servico.all.select{|s| s.status=="Novo"}
    end

    def self.retirados
        Servico.all.select{|s| s.status=="Retirado"}
    end

    def self.mantidos
        Servico.all.select{|s| s.status=="Mantido"}
    end

    def self.atuais
        Servico.all.select{|s| s.status == "Novo" || s.status == "Mantido"}
    end

    def last
        @last = self.avaliacos.sort_by{|a| a.tempo.data}.last
    end
    
    def total
        self.last.total
    end

    def aprovacao
        self.last.aprov
    end

    def pos_periodo(data_inicial, data_final)
        @pos_fin = 0
        @pos_ini = 0
        self.avaliacos.select{|a| a.tempo.data == data_final.to_date}.each do |av|
            @pos_fin += av.positivas
        end
        self.avaliacos.select{|a| a.tempo.data == data_inicial.to_date}.each do |av|
            @pos_ini += av.positivas
        end
        return @pos_fin - @pos_ini
    end

    def neg_periodo(data_inicial, data_final)
        @neg_fin = 0
        @neg_ini = 0
        self.avaliacos.select{|a| a.tempo.data == data_final.to_date}.each do |av|
            @neg_fin += av.negativas
        end
        self.avaliacos.select{|a| a.tempo.data == data_inicial.to_date}.each do |av|
            @neg_ini += av.negativas
        end
        return @neg_fin - @neg_ini
    end

    def tot_periodo(data_inicial, data_final)
        @tot_fin = 0
        @tot_ini = 0
        self.avaliacos.select{|a| a.tempo.data == data_final.to_date}.each do |av|
            @tot_fin += av.total
        end
        self.avaliacos.select{|a| a.tempo.data == data_inicial.to_date}.each do |av|
            @tot_ini += av.total
        end
        return @tot_fin - @tot_ini
    end

    def aprov_periodo(data_inicial, data_final)
        self.pos_periodo(data_inicial, data_final).to_f/(self.tot_periodo(data_inicial, data_final) == 0 ? 1 : self.tot_periodo(data_inicial, data_final))
    end

    def impacto_periodo(data_inicial, data_final, total)
        ((self.tot_periodo(data_inicial, data_final).to_f/(total == 0 ? 1 : total))*self.aprov_periodo(data_inicial, data_final)) -  ((self.tot_periodo(data_inicial, data_final).to_f/(total == 0 ? 1 : total))*(1 - self.aprov_periodo(data_inicial, data_final)))
    end

end
