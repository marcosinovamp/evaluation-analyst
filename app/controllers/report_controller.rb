class ReportController < ApplicationController

  def home
    basics
  end

  def relatorio
    basics
    @novos = Servico.novos.size
    @retirados = Servico.retirados.size
    @mantidos = Servico.mantidos.size
    @atuais = Servico.atuais.size
    @data_inicial = Tempo.cronos[-2].data
    @data_final = Tempo.cronos.last.data
    @status = Tempo.cronos.last.status
    @varapv = Tempo.cronos.last.aprovacao - Tempo.cronos[-2].aprovacao
    @mais_novos = Orgao.mais_novos
    @mais_retirados = Orgao.mais_retirados
    @mais_servicos = Orgao.mais_servicos
    @mavalper = Orgao.mais_aval_periodo
    @mposper = Orgao.mais_pos_periodo
    @mnegper = Orgao.mais_neg_periodo
    @imp_periodo = Orgao.mais_imp_per
    @var_apv = Orgao.var_aprovacao
    @outp = Orgao.mais_outperf
    @serv_map = Servico.mais_aval_periodo
    @serv_mpp = Servico.mais_pos_periodo
    @serv_mnp = Servico.mais_neg_periodo
    @serv_best = Servico.melhor_avaliados
  end

  private

  def basics
    @orgaos = Orgao.all.includes(:servicos)
    @datas = Tempo.all.includes(:avaliacos)
  end

end