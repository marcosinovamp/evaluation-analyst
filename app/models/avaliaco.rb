class Avaliaco < ApplicationRecord
    belongs_to :tempo
    belongs_to :servico
    has_one :orgao, through: :servico

# CLASS METHODS
    ## LAST VALUES

    def self.last_posit
        @lastPosit = 0
        Avaliaco.select{|s| s.tempo.data == Tempo.cronos.last}.each do |aval|
            @lastPosit += aval.positivas.to_i
        end
        return @lastPosit
    end

    def self.last_negat
        @lastNegat = 0
        Avaliaco.select{|s| s.tempo.data == Tempo.cronos.last}.each do |aval|
            @lastNegat += aval.negativas.to_i
        end
        return @lastNegat
    end

    def self.last_total
        @lastTotal = 0
        Avaliaco.select{|s| s.tempo.data == Tempo.cronos.last}.each do |aval|
            @lastTotal += aval.total.to_i
        end
        return @lastTotal
    end

    def self.aprovacao
        ap = Avaliaco.last_posit.to_f/(Avaliaco.last_total == 0 ? 1 : 0)
        return ap
    end

    ## END OF LAST VALUES
    ## PERIOD VALUES

    def self.pos_periodo(data_inicial, data_final)
        @posit_inicial = 0
        @posit_final = 0
        Avaliaco.all.select{|a| a.tempo.data == data_inicial.to_date}.each do |ai|
            @posit_inicial += ai.positivas
        end
        Avaliaco.all.select{|a| a.tempo.data == data_final.to_date}.each do |af|
            @posit_final += af.positivas
        end
        return @posit_final - @posit_inicial
    end

    def self.neg_periodo(data_inicial, data_final)
        @negat_inicial = 0
        @negat_final = 0
        Avaliaco.all.select{|a| a.tempo.data == data_inicial.to_date}.each do |ai|
            @negat_inicial += ai.negativas
        end
        Avaliaco.all.select{|a| a.tempo.data == data_final.to_date}.each do |af|
            @negat_final += af.negativas
        end
        return @negat_final - @negat_inicial
    end

    def self.tot_periodo(data_inicial, data_final)
        Avaliaco.pos_periodo(data_inicial, data_final) + Avaliaco.neg_periodo(data_inicial, data_final)
    end
    
    ## END OF PERIOD VALUES

# END OF CLASS METHODS

end
