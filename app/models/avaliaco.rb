class Avaliaco < ApplicationRecord
    belongs_to :tempo
    belongs_to :servico
    has_one :orgao, through: :servico

    def participacao
        self.total.to_f/Tempo.cronos.last.total == 0 ? 1: Tempo.cronos.last.total
    end

    def impacto_pos
        self.aprov*self.participacao
    end

    def impacto_neg
        (1 - self.aprov)*self.participacao
    end

    def impacto
        self.impacto_pos - self.impacto_neg
    end

    def part_periodo
        self.tot_periodo.to_f/Tempo.cronos.last.total == 0 ? 1: Tempo.cronos.last.total
    end

    def imppos_periodo
        self.apv_periodo*self.part_periodo
    end

    def impneg_periodo
        (1 - self.apv_periodo)*self.part_periodo
    end

    def imp_periodo
        self.imppos_periodo - self.impneg_periodo
    end





end
