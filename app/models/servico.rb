class Servico < ApplicationRecord
    belongs_to :orgao
    has_many :avaliacos
    has_many :tempos, through: :avaliacos


# CLASS METHODS
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

# END OF CLASS METHODS
# OBJECT METHODS
    ## LAST VALUES

    def last
        self.avaliacos.sort_by{|a| a.tempo.data}.last
    end
    
    def positivas
        self.last.positivas
    end

    def negativas
        self.last.negativas
    end
    
    def total
        self.last.total
    end

    def aprovacao
        self.last.aprov
    end

    ## END OF LAST VALUES
    ## PERIOD VALUES

    def pos_periodo(data_inicial, data_final)
        self.avaliacos.select{|a| a.tempo.data == data_final.to_date}.first.positivas - self.avaliacos.select{|a| a.tempo.data == data_inicial.to_date}.first.positivas 
    end

    def neg_periodo(data_inicial, data_final)
        self.avaliacos.select{|a| a.tempo.data == data_final.to_date}.first.negativas - self.avaliacos.select{|a| a.tempo.data == data_inicial.to_date}.first.negativas
    end

    def tot_periodo(data_inicial, data_final)
        self.avaliacos.select{|a| a.tempo.data == data_final.to_date}.first.total - self.avaliacos.select{|a| a.tempo.data == data_inicial.to_date}.first.total
    end

    def aprov_periodo(data_inicial, data_final)
        self.avaliacos.select{|a| a.tempo.data == data_final.to_date}.first.aprov - self.avaliacos.select{|a| a.tempo.data == data_inicial.to_date}.first.aprov
    end

    ## END OF PERIOD VALUES
    ## DATED VALUES

    def pos_ontime(data)
        self.avaliacos.select{|a| a.tempo.data == data.to_date}.first.positivas
    end

    def neg_ontime(data)
        self.avaliacos.select{|a| a.tempo.data == data.to_date}.first.negativas
    end

    def tot_ontime(data)
        self.avaliacos.select{|a| a.tempo.data == data.to_date}.first.total
    end

    def apv_ontime(data)
        self.avaliacos.select{|a| a.tempo.data == data.to_date}.first.aprov
    end

    ## END OF DATED VALUES

# END OF OBJECT METHODS

end
