class ReportController < ApplicationController

  def home
    basics
  end

  def relatorio
    basics
    @data_inicial = @datas[-2].data
    @data_final = @datas.last.data
    @total_novos = 0
    @posit_novos = 0
    @negat_novos = 0
    @servicos.novos.each do |s|
      s.avaliacos.select{|a| a.tempo.data == @datas.last.data.to_date}.each do |av|
        @total_novos += av.tot_periodo
        @posit_novos += av.pos_periodo
        @negat_novos += av.neg_periodo
      end
    end
    @total_retirados = 0
    @posit_retirados = 0
    @negat_retirados = 0
    @servicos.retirados.each do |s|
      s.avaliacos.select{|a| a.tempo.data == @datas.last.data.to_date}.each do |av|
        @total_retirados += av.total
        @posit_retirados += av.positivas
        @negat_retirados += av.negativas
      end
    end
    @total_mantidos = 0
    @posit_mantidos = 0
    @negat_mantidos = 0
    @servicos.mantidos.each do |s|
      s.avaliacos.select{|a| a.tempo.data == @datas.last.data.to_date}.each do |av|
        @total_mantidos += av.tot_periodo
        @posit_mantidos += av.pos_periodo
        @negat_mantidos += av.neg_periodo
      end
    end
    @mais_novos = @orgaos.sort_by{|o| o.novos_serv*-1}
    @mais_retirados = @orgaos.sort_by{|o| o.retirados_serv*-1}
    @mais_servicos = @orgaos.sort_by{|o| o.servicos.size*-1}
    @mais_avaliacoes = @orgaos.sort_by{|o| o.tot_periodo*-1}
    @mais_positivas = @orgaos.sort_by{|o| o.pos_periodo*-1}
    @mais_negativas = @orgaos.sort_by{|o| o.neg_periodo*-1}
  end

  private

  def basics
    @servicos = Servico.all
    @avaliacoes = Avaliaco.all
    @orgaos = Orgao.all
    @datas = Tempo.cronos
  end

end