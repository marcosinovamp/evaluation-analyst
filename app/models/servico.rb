class Servico < ApplicationRecord
    has_many :avaliacos
    belongs_to :orgao

    def self.novos
        Servico.all.select{|s| s.status=="Novo"}
    end

    def self.retirados
        Servico.all.select{|s| s.status=="Retirado"}
    end

    def self.mantidos
        Servico.all.select{|s| s.status=="Mantido"}
    end

    def datas
        @data = []
        self.avaliacos.each do |a|
            if @data.include?(a.data.to_date) == false
                @data << a.data.to_date
            end
        end
        @data = @data.sort
    end

    def last
        @last = self.avaliacos.sort_by{|a| a.data}.last
    end
    
    def total
        self.last.positivas + self.last.negativas
    end

    def aprovacao
        self.last.positivas.to_f/self.total
    end

    def pos_periodo(data_inicial, data_final)
        @pos_fin = 0
        @pos_ini = 0
        self.avaliacos.select{|a| a.data.to_date == data_final.to_date}.each do |av|
            @pos_fin += av.positivas
        end
        self.avaliacos.select{|a| a.data.to_date == data_inicial.to_date}.each do |av|
            @pos_ini += av.positivas
        end
        return @pos_fin - @pos_ini
    end

    def neg_periodo(data_inicial, data_final)
        @neg_fin = 0
        @neg_ini = 0
        self.avaliacos.select{|a| a.data.to_date == data_final.to_date}.each do |av|
            @neg_fin += av.negativas
        end
        self.avaliacos.select{|a| a.data.to_date == data_inicial.to_date}.each do |av|
            @neg_ini += av.negativas
        end
        return @neg_fin - @neg_ini
    end

    def tot_periodo(data_inicial, data_final)
        self.pos_periodo(data_inicial, data_final) + self.neg_periodo(data_inicial, data_final)
    end

    def aprov_periodo(data_inicial, data_final)
        self.pos_periodo(data_inicial, data_final)/self.tot_periodo(data_inicial, data_final)
    end

    def impacto_periodo(data_inicial, data_final, total)
        ((self.tot_periodo(data_inicial, data_final)/total)*self.aprov_periodo(data_inicial, data_final)) -  ((self.tot_periodo(data_inicial, data_final)/total)*(1 - self.aprov_periodo(data_inicial, data_final)))
    end

end
