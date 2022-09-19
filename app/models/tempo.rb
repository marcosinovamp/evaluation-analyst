class Tempo < ApplicationRecord
    has_many :avaliacos

    def self.cronos
        @cronos_memo ||= Tempo.all.sort_by{|t| t.data}
    end

    def status
        @total_novos = 0
        @posit_novos = 0
        @negat_novos = 0
        @tot_periodo_novos = 0
        @pos_periodo_novos = 0
        @neg_periodo_novos = 0
        @total_retirados = 0
        @posit_retirados = 0
        @negat_retirados = 0
        @tot_periodo_retirados = 0
        @pos_periodo_retirados = 0
        @neg_periodo_retirados = 0
        @total_mantidos = 0
        @posit_mantidos = 0
        @negat_mantidos = 0
        @tot_periodo_mantidos = 0
        @pos_periodo_mantidos = 0
        @neg_periodo_mantidos = 0
        @total_all = 0
        @posit_all = 0
        @negat_all = 0
        @tot_periodo_all = 0
        @pos_periodo_all = 0
        @neg_periodo_all = 0
        self.avaliacos.each do |av|
            @total_all += av.total
            @posit_all += av.positivas
            @negat_all += av.negativas
            @tot_periodo_all += av.tot_periodo
            @pos_periodo_all += av.pos_periodo
            @neg_periodo_all += av.neg_periodo
            if Servico.find(av.servico_id).status == "Novo"
                @total_novos += av.total
                @posit_novos += av.positivas
                @negat_novos += av.negativas
                @tot_periodo_novos += av.tot_periodo
                @pos_periodo_novos += av.pos_periodo
                @neg_periodo_novos += av.neg_periodo
            elsif Servico.find(av.servico_id).status == "Retirado"
                @total_retirados += av.total
                @posit_retirados += av.positivas
                @negat_retirados += av.negativas
                @tot_periodo_retirados += av.tot_periodo
                @pos_periodo_retirados += av.pos_periodo
                @neg_periodo_retirados += av.neg_periodo
            elsif Servico.find(av.servico_id).status == "Mantido"
                @total_mantidos += av.total
                @posit_mantidos += av.positivas
                @negat_mantidos += av.negativas
                @tot_periodo_mantidos += av.tot_periodo
                @pos_periodo_mantidos += av.pos_periodo
                @neg_periodo_mantidos += av.neg_periodo
            end
        end
        return {novos_total: @total_novos, novos_positivas: @posit_novos, novos_negativas: @negat_novos, novos_tot_periodo: @tot_periodo_novos, novos_pos_periodo: @pos_periodo_novos, novos_neg_periodo: @neg_periodo_novos, retirados_total: @total_retirados, retirados_positivas: @posit_retirados, retirados_negativas: @negat_retirados, retirados_tot_periodo: @tot_periodo_retirados, retirados_pos_periodo: @pos_periodo_retirados, retirados_neg_periodo: @neg_periodo_retirados, mantidos_total: @total_mantidos, mantidos_positivas: @posit_mantidos, mantidos_negativas: @negat_mantidos, mantidos_tot_periodo: @tot_periodo_mantidos, mantidos_pos_periodo: @pos_periodo_mantidos, mantidos_neg_periodo: @neg_periodo_mantidos, positivas: @posit_all, negativas: @negat_novos, total: @total_all, tot_periodo: @tot_periodo_all, pos_periodo: @pos_periodo_all, neg_periodo: @neg_periodo_all, aprovacao: @posit_all.to_f/(@total_all == 0 ? 1 : @total_all), apv_periodo: @pos_periodo_all.to_f/(@tot_periodo_all == 0 ? 1 : @tot_periodo_all) }
    end

end
