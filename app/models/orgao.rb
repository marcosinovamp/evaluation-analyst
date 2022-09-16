class Orgao < ApplicationRecord
    has_many :servicos
    has_many :avaliacos, through: :servicos

    def pos_aval(data)
        @pos = 0
        self.avaliacos.select{|a| a.data.to_date == data.to_date}.each do |p|
            if p.nil? == false
                @pos += p.positivas
            end
        end
        return @pos
    end

    def neg_aval(data)
        @neg = 0
        self.avaliacos.select{|a| a.data.to_date == data.to_date}.each do |n|
            if n.nil? == false
                @neg += n.negativas
            end
        end
        return @neg
    end

    def tot_aval(data)
        self.pos_aval(data) + self.neg_aval(data)
    end

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

end
