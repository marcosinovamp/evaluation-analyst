class ReportController < ApplicationController

  def home
    @servicos = Servico.all
  end

  def relatorio
    @servicos = Servico.all
    @avaliacoes = Avaliaco.all
    @orgaos = Orgao.all
    @data = []
    Avaliaco.all.each do |a|
        if @data.include?(a.data.to_date) == false
            @data << a.data.to_date
        end
    end
    @pos = 0
    @neg = 0
    @servicos.select{|s| s.status == "Novo"}.each do |novo|
      @pos += novo.avaliacos.last.positivas
      @neg += novo.avaliacos.last.negativas
    end
    @rpos = 0
    @rneg = 0
    @servicos.select{|s| s.status == "Retirado"}.each do |retir|
      @rpos += retir.avaliacos.last.positivas
      @rneg += retir.avaliacos.last.negativas
    end
    @mpos = 0
    @mneg = 0
    @servicos.select{|s| s.status == "Mantido"}.each do |mant|
      @mpos += mant.avaliacos.last.positivas
      @mneg += mant.avaliacos.last.negativas
    end
    @antpos = 0
    Avaliaco.select{|s| s.data.to_date == @data.sort[-2]}.each do |aval|
      @antpos += aval.positivas.to_i
    end
    @antneg = 0
    Avaliaco.select{|s| s.data.to_date == @data.sort[-2]}.each do |aval|
      @antneg += aval.negativas.to_i
    end
    @anttot = @antpos + @antneg
    @antapv = @antpos.to_f/@anttot
    @varap = Avaliaco.aprovacao - @antapv
    @mais_novos = Orgao.all.sort_by{|o| o.novos_serv*-1}
    @mais_retira = Orgao.all.sort_by{|o| o.retirados_serv*-1}
    @mais_aval_per = Orgao.all.sort_by{|o| o.tot_periodo*-1}
    @mais_pos_per = Orgao.all.sort_by{|o| o.pos_periodo*-1}
    @mais_neg_per = Orgao.all.sort_by{|o| o.neg_periodo*-1}


  end
   
end
