require 'faker'

class ReportController < ApplicationController
  
  def home
    @orgaos = Orgao.all.includes(:servicos, :avaliacos, :derivados)
  end
  
  def documento
    data
    @comp_avals = []
    @cronos.each do |c|
      @comp_avals << [c.data, c.aprovacao_media, c.aprovacao_periodo]
    end
    @last = @comp_avals.pop
    @pie_data = []
    @click = 0
    @demais = 0
    @deadline = @org_map.first.fotografia_periodo[0]
    @org_map.each do |o|
      if (@cronos_last.fotografia_periodo[0] - @click) > @deadline
        @click += o.fotografia_periodo[0]
        @pie_data << [o.nome_fantasia, o.fotografia_periodo[0]]
      end
      if @pie_data.include?([o.nome_fantasia, o.fotografia_periodo[0]]) == false
        @demais += o.fotografia_periodo[0]
      end
    end
  end

  def relatorio
   data
   data_comp
  end

  def orgao
    @atuais = Servico.atuais # r d
    @orgao = Orgao.find(params[:id])
    @servicos = @orgao.servicos
    @avaliacos = @orgao.avaliacos.includes(:derivados, :tempo)
    @mais_aval = @servicos.sort_by{|s| s.qtd_avaliacoes*-1}
    @mais_posit = @servicos.sort_by{|s| s.qtd_positivas*-1}
    @mais_negat = @servicos.sort_by{|s| s.qtd_negativas*-1}
    @mais_aprov = @servicos.select{|s| s.qtd_avaliacoes > 10}.sort_by{|s| s.aprovacao_geral*-1}
    @menos_aprov = @servicos.select{|s| s.qtd_avaliacoes > 10}.sort_by{|s| s.aprovacao_geral}
    @avaliados = @servicos.select{|s| s.qtd_avaliacoes > 0}
    @data_chart = []
    @data_per = []
    @aprov = []
    Tempo.all.each do |t|
        @data_chart << [t.data.to_s, @orgao.fotografia_antiga(t.id)[2], @orgao.fotografia_antiga(t.id)[0], @orgao.fotografia_antiga(t.id)[1]]
        @data_per << [t.data.to_s, @orgao.fotografia_antiga(t.id)[5], @orgao.fotografia_antiga(t.id)[3], @orgao.fotografia_antiga(t.id)[4]]
        @aprov << [ t.data, @orgao.fotografia_antiga(t.id)[6], @orgao.fotografia_antiga(t.id)[7]]
    end
    @data_per.shift(2)
    @last = @data_chart.pop
    @lst_per = @data_per.pop
    @lst_apv = @aprov.pop
  end

  def servico
    @servico = Servico.find(params[:id])
    @cronos = Tempo.cronos
    @cronos_per = @cronos[1..1000]
    @avaliacoes = @servico.avaliacos[1..1000]
    @derivados = @servico.derivados[1..1000]
    @aval = @servico.avaliacos[0..-1]
    @avlast = @servico.avaliacos.last
  end

  def rascunho
    @orgaos = Orgao.all.includes(:servicos, :avaliacos, :derivados) # r d
    @orgaos1000 = Orgao.mais1000 # r d 
    @cronos = Tempo.cronos # r d
    @cronos_last = @cronos.last # r d
    @novos = Servico.novos # r d
    @retirados = Servico.retirados # r d
    @atuais = Servico.atuais # r d
    @org_msn = @orgaos.sort_by{|o| o.novos.size*-1} # r d
    @org_msr = @orgaos.sort_by{|o| o.retirados.size*-1} # r d
    @org_msa = @orgaos.sort_by{|o| o.atuais.size*-1} # r d
  end


  private

  def data
    @cronos = Tempo.cronos # r d
    @cronos_last = @cronos.last # r d
    @cronos_fot_geral = @cronos_last.fotografia_geral # r d
    @cronos_fot_periodo = @cronos_last.fotografia_periodo # r d
    @novos = Servico.novos # r d
    @retirados = Servico.retirados # r d
    @mantidos = Servico.mantidos # r d
    @atuais = Servico.atuais # r d
    @av_novos = Servico.aval_novos # r d
    @av_retirados = Servico.aval_retirados # r d
    @av_mantidos = Servico.aval_mantidos # r d
    @orgaos = Orgao.all.includes(:servicos, :avaliacos, :derivados) # r d
    @orgaos1000 = Orgao.mais1000 # r d 
    @varapvmedia = @cronos.last.aprovacao_media - @cronos[-2].aprovacao_media # r d
    @serv_map = @atuais.sort_by{|s| s.qtd_avaliacoes_periodo*-1} # r d
    @serv_mpp = @atuais.sort_by{|s| s.qtd_positivas_periodo*-1} #r d
    @serv_mnp = @atuais.sort_by{|s| s.qtd_negativas_periodo*-1} # r d
    @serv_mapvg = Servico.mais1000.sort_by{|s| s.aprovacao_geral*-1} # r d
    @org_msn = @orgaos.sort_by{|o| o.novos.size*-1} # r d
    @org_msr = @orgaos.sort_by{|o| o.retirados.size*-1} # r d
    @org_msa = @orgaos.sort_by{|o| o.atuais.size*-1} # r d
    @org_map = @orgaos.sort_by{|o| o.fotografia_periodo[0]*-1} # r d
    @org_mpp = @orgaos.sort_by{|o| o.fotografia_periodo[1]*-1} # r d
    @org_mnp = @orgaos.sort_by{|o| o.fotografia_periodo[2]*-1} # r d
    @org_mimpp =  @orgaos.sort_by{|o| o.impacto_periodo.abs*-1} # r d
    @org_difap = Orgao.mais100.sort_by{|o| o.var_aprovacao_media*-1} # r d
    @org_outp = Orgao.mais100.sort_by{|o| o.outperformance*-1} # r d
  end

  def data_comp
    @serv_mag = @atuais.sort_by{|s| s.qtd_avaliacoes*-1} # r
    @serv_mpg = @atuais.sort_by{|s| s.qtd_positivas*-1} # r
    @serv_mng = @atuais.sort_by{|s| s.qtd_negativas*-1} # r
    @serv_mapvp = Servico.mais10.sort_by{|s| s.aprovacao_periodo*-1} # r
    @serv_mig = @atuais.sort_by{|s| s.impacto_geral*-1} # r
    @serv_mip = @atuais.sort_by{|s| s.impacto_periodo*-1} # r
    @org_mag = @orgaos.sort_by{|o| o.fotografia_geral[0]*-1} # r
    @org_mpg = @orgaos.sort_by{|o| o.fotografia_geral[1]*-1} # r
    @org_mng = @orgaos.sort_by{|o| o.fotografia_geral[2]*-1} # r
    @org_mapvg = @orgaos1000.sort_by{|o| o.aprovacao_media*-1} # r
    @org_mapvp = Orgao.mais100.sort_by{|o| o.aprovacao_periodo*-1} # r
    @org_mparg = @orgaos.sort_by{|o| o.participacao_media*-1} # r
    @org_mparp = @orgaos.sort_by{|o| o.participacao_periodo*-1} # r
    @org_mimpg = @orgaos.sort_by{|o| o.impacto_medio.abs*-1} # r
  end

end