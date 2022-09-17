class Orgao < ApplicationRecord
    has_many :servicos
    has_many :avaliacos, through: :servicos
    has_many :tempos, through: :avaliacos

# CLASS METHODS

    def self.total
        Orgao.all.size
    end

# END OF CLASS METHODS
# OBJECT METHODS
    ## SERVICES

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

    ## END OF SERVICES
    ## LAST VALUES

    def last
        @last = []
        self.servicos.each do |s|
           @last << s.avaliacos.sort_by{|a| a.tempo.data}.last
        end
        return @last
    end

    def positivas
        @pos = 0
        self.last.each do |a|
          @pos += a.positivas
        end
        return @pos
    end

    def negativas
        @neg = 0
        self.last.each do |a|
          @neg += a.negativas
        end
        return @neg
    end
    
    def total
        @tot = 0
        self.last.each do |a|
          @tot += a.total
        end
        return @tot
    end

    def aprovacao
        self.positivas/(self.total == 0 ? 1 : self.total)
    end

    ## END OF LAST VALUES
    ## PERIOD VALUES  

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

    ## END OF PERIODS VALUES
    ## DATED VALUES

    def pos_aval(data)
        @pos = 0
        self.avaliacos.select{|a| a.tempo.data == data.to_date}.each do |p|
            if p.nil? == false
                @pos += p.positivas
            end
        end
        return @pos
    end

    def neg_aval(data)
        @neg = 0
        self.avaliacos.select{|a| a.tempo.data == data.to_date}.each do |n|
            if n.nil? == false
                @neg += n.negativas
            end
        end
        return @neg
    end

    def tot_aval(data)
        @tot = 0
        self.avaliacos.select{|a| a.tempo.data == data.to_date}.each do |t|
            if t.nil? == false
                @tot += t.total
            end
        end
        return @tot
    end

    ## END OF DATED VALUES

# END OF OBJECT METHODS
end
