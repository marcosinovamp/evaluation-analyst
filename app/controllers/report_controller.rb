class ReportController < ApplicationController

  def home
    @servicos = Servico.all
  end

  def relatorio
    @servicos = Servico.all
    @avaliacoes = Avaliaco.all
    @orgaos = Orgao.all
    @data = Tempo.cronos
    # @nov_pos_per = 0
    # @nov_neg_per = 0
    # @nov_tot_per = 0
    # @servicos.novos.each do |s|
    #   @nov_pos_per += s.pos_periodo(@data[-2].data, @data.last.data)
    #   @nov_neg_per += s.neg_periodo(@data[-2].data, @data.last.data)
    #   @nov_tot_per += s.tot_periodo(@data[-2].data, @data.last.data)
    # end
    # @ret_pos = 0
    # @ret_neg = 0
    # @ret_tot = 0
    # @servicos.retirados.each do |s|
    #   @ret_pos += s.last.positivas
    #   @ret_neg += s.last.negativas
    #   @ret_tot += s.last.total
    # end
    # @mant_pos_per = 0
    # @mant_neg_per = 0
    # @mant_tot_per = 0
    # @servicos.mantidos.each do |s|
    #   @mant_pos_per += s.pos_periodo(@data[-2].data, @data.last.data)
    #   @mant_neg_per += s.neg_periodo(@data[-2].data, @data.last.data)
    #   @mant_tot_per += s.tot_periodo(@data[-2].data, @data.last.data)
    # end
    # @orgs_novo_serv =  @orgaos.sort_by{|o| o.novos_serv*-1}
    # @orgs_retir_serv =  @orgaos.sort_by{|o| o.retirados_serv*-1}
    # @orgs_qtd_serv = @orgaos.sort_by{|o| o.qtd_atual*-1}
    # @orgs_tot_per = @orgaos.sort_by{|o| o.tot_periodo(@data[-2].data, @data.last.data)*-1}
    # @orgs_pos_per = @orgaos.sort_by{|o| o.pos_periodo(@data[-2].data, @data.last.data)*-1}
    # @orgs_neg_per = @orgaos.sort_by{|o| o.neg_periodo(@data[-2].data, @data.last.data)*-1}
    # @orgs_imp_per = @orgaos.sort_by{|o| o.impacto_periodo(@data[-2].data, @data.last.data, (@data.last.total - @data[-2].total))}
    # @orgs_apv_var = @orgaos.sort_by{|o| (o.pos_aval(@data.last.data)/(o.tot_aval(@data.last.data) == 0 ? 1 : o.tot_aval(@data.last.data)) - (o.pos_aval(@data[-2].data)/(o.tot_aval(@data[-2].data) == 0 ? 1 : o.tot_aval(@data[-2].data))))*-1}

  end
   
end

# @pos = 0
# @neg = 0
# @servicos.novos.each do |novo|
#   @pos += novo.pos_periodo(@data[-2], @data.last)
#   @neg += novo.avaliacos.neg_periodo(@data[-2], @data.last)
# end
# @rpos = 0
# @rneg = 0
# @servicos.retirados.each do |retir|
#   @rpos += retir.pos_periodo(@data.first, @data.last)
#   @rneg += retir.neg_periodo(@data.first, @data.last)
# end
# @pos_per = 0
# @neg_per = 0
# @tot_per = 0
# @servicos.mantidos.each do |s|
#   @pos_per += s.pos_periodo(@data[-2], @data.last)
  


# @antpos = 0
# Avaliaco.select{|s| s.data.to_date == @data.sort[-2]}.each do |aval|
#   @antpos += aval.positivas.to_i
# end
# @antneg = 0
# Avaliaco.select{|s| s.data.to_date == @data.sort[-2]}.each do |aval|
#   @antneg += aval.negativas.to_i
# end
# @anttot = @antpos + @antneg
# @antapv = @antpos.to_f/@anttot
# @varap = Avaliaco.aprovacao - @antapv
# @mais_novos = Orgao.all.sort_by{|o| o.novos_serv*-1}
# @mais_retira = Orgao.all.sort_by{|o| o.retirados_serv*-1}
# @mais_aval_per = Orgao.all.sort_by{|o| o.tot_periodo(@data[-2], @data.last)*-1}
# @mais_pos_per = Orgao.all.sort_by{|o| o.pos_periodo(@data[-2], @data.last)*-1}
# @mais_neg_per = Orgao.all.sort_by{|o| o.neg_periodo(@data[-2], @data.last)*-1}
# @pos_per = 0
# @neg_per = 0
# @tt_periodo = 0
# Servico.mantidos.each do |s|
#   if s.avaliacos.select{|a| a.tempo.data == @data.last}.nil? == false
#     if  s.avaliacos.select{|a| a.data.to_date == @data[-2]}.nil? || s.avaliacos.select{|a| a.data.to_date == @data[-2]} == 0
#       @pos_per += s.last.positivas
#       @neg_per += s.last.negativas
#     else
#       @pos_per += s.pos_periodo(@data[-2], @data.last)
#       @neg_per += s.neg_periodo(@data[-2], @data.last)
#     end
#   end
# end
# @tt_periodo = @pos_per + @neg_per
# @maior_pos_imp = Orgao.all.sort_by{|o| o.impacto_periodo(@data[-2], @data.last, Avaliaco.tot_periodo(@data[-2], @data.last))*-1}