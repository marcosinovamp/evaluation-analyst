class Derivado < ApplicationRecord
    belongs_to :avaliaco
    belongs_to :servico
    belongs_to :orgao
    belongs_to :tempo
end