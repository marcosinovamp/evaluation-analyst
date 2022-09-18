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
    
end