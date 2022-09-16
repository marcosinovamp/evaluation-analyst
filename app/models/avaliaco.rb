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

end
