class ReportController < ApplicationController

  def home
  end

  def relatorio
    @varapvmedia = Tempo.cronos.last.aprovacao_media - Tempo.cronos[-2].aprovacao_media
    @atuais = Servico.atuais
    @serv_mag = @atuais.sort_by{|s| s.qtd_avaliacoes*-1}
    @serv_map = @atuais.sort_by{|s| s.qtd_avaliacoes_periodo*-1}
    @serv_mpg = @atuais.sort_by{|s| s.qtd_positivas*-1}
    @serv_mpp = @atuais.sort_by{|s| s.qtd_positivas_periodo*-1}
    @serv_mng = @atuais.sort_by{|s| s.qtd_negativas*-1}
    @serv_mnp = @atuais.sort_by{|s| s.qtd_negativas_periodo*-1}
    @serv_mapvg = Servico.mais1000.sort_by{|s| s.aprovacao_geral*-1}
    @serv_mapvp = Servico.mais10.sort_by{|s| s.aprovacao_periodo*-1}
    @serv_mig = @atuais.sort_by{|s| s.impacto_geral*-1}
    @serv_mip = @atuais.sort_by{|s| s.impacto_periodo*-1}
    @orgaos = Orgao.all.includes(:servicos, :avaliacos, :derivados)
    @org_msn = @orgaos.sort_by{|o| o.novos*-1}
    @org_msr = @orgaos.sort_by{|o| o.retirados*-1}
    @org_msa = @orgaos.sort_by{|o| o.atuais*-1}
    @org_mag = @orgaos.sort_by{|o| o.fotografia_geral[0]*-1}
    @org_map = @orgaos.sort_by{|o| o.fotografia_periodo[0]*-1}
    @org_mpg = @orgaos.sort_by{|o| o.fotografia_geral[1]*-1}
    @org_mpp = @orgaos.sort_by{|o| o.fotografia_periodo[1]*-1}
    @org_mng = @orgaos.sort_by{|o| o.fotografia_geral[2]*-1}
    @org_mnp = @orgaos.sort_by{|o| o.fotografia_periodo[2]*-1}


  end

end