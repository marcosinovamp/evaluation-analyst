class Avaliaco < ApplicationRecord
    belongs_to :servico
    has_one :orgao, through: :servico

    def self.last_posit
        @lastPosit = 0
        @data = []
        Avaliaco.all.each do |a|
            if @data.include?(a.data.to_date) == false
                @data << a.data.to_date
            end
        end
        Avaliaco.select{|s| s.data.to_date == @data.sort.last}.each do |aval|
            @lastPosit += aval.positivas.to_i
        end
        return @lastPosit
    end

    def self.last_negat
        @lastNegat = 0
        @data = []
        Avaliaco.all.each do |a|
            if @data.include?(a.data.to_date) == false
                @data << a.data.to_date
            end
        end
        Avaliaco.select{|s| s.data.to_date == @data.sort.last}.each do |aval|
            @lastNegat += aval.negativas.to_i
        end
        return @lastNegat
    end

    def self.last_total
        Avaliaco.last_posit + Avaliaco.last_negat
    end

    def self.aprovacao
        ap = Avaliaco.last_posit.to_f/Avaliaco.last_total
        return ap
    end

    def self.pos_periodo(data_inicial, data_final)
        @posit_inicial = 0
        @posit_final = 0
        Avaliaco.all.select{|a| a.data.to_date == data_inicial.to_date}.each do |ai|
            @posit_inicial += ai.positivas
        end
        Avaliaco.all.select{|a| a.data.to_date == data_final.to_date}.each do |af|
            @posit_final += af.positivas
        end
        return @posit_final - @posit_inicial
    end

    def self.neg_periodo(data_inicial, data_final)
        @negat_inicial = 0
        @negat_final = 0
        Avaliaco.all.select{|a| a.data.to_date == data_inicial.to_date}.each do |ai|
            @negat_inicial += ai.negativas
        end
        Avaliaco.all.select{|a| a.data.to_date == data_final.to_date}.each do |af|
            @negat_final += af.negativas
        end
        return @negat_final - @negat_inicial
    end

    def self.tot_periodo(data_inicial, data_final)
        Avaliaco.pos_periodo(data_inicial, data_final) + Avaliaco.neg_periodo(data_inicial, data_final)
    end

end
