# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require "csv"
require "json"
require "open-uri"

if Tempo.all.size == 0

    filepath = "db/tempo.csv"

    CSV.foreach(filepath) do |row|
        Tempo.create({data:row[1].to_date, order:row[2] })
    end
end
if Orgao.all.size == 0

    filepath2 = "db/orgaos.csv"

    CSV.foreach(filepath2) do |row|
        Orgao.create({nome:row[1].gsub("1w1", ","), nome_fantasia:row[2].gsub("1w1", ","), artigo:row[3], siorg:row[4] })
    end
end
if Servico.all.size == 0

    filepath3 = "db/servicos.csv"

    CSV.foreach(filepath3, headers: :first_row) do |row|
        Servico.create(api_id:row[0], nome:row[1].gsub('$§', ','), status:row[2], orgao_id:row[3])
    end
end
if Avaliaco.all.size == 0
    
    filepath4 = "db/avaliacoes.csv"
    CSV.foreach(filepath4, headers: :first_row) do |row|
        Avaliaco.create(positivas:row[0], negativas:row[1], total:row[2], pos_periodo:row[3], neg_periodo:row[4], tot_periodo:row[5], tempo_id:row[6], servico_id:row[7])
    end
end

filepath4 = "db/avaliacoes.csv"
@tmpsper = {}
@tmps = {}
CSV.foreach(filepath4, headers: :first_row) do |row|
    @tmps[row[6]] += row[2]
    @tmpsper[row[6]] += row[5]
end

if Derivado.all.size == 0

    Avaliaco.all.each do |a|
        Derivado.create(participacao: a.total.to_f/@tmps[a.tempo_id], aprovacao: a.positivas.to_f/(a.total == 0 ? 1 : a.total), part_periodo: a.tot_periodo.to_f/@tmpsper[a.tempo_id], aprov_periodo: a.pos_periodo.to_f/(a.tot_periodo == 0 ? 1 : a.tot_periodo),  avaliaco_id: a.id, servico_id: a.servico_id, tempo_id: a.tempo_id, orgao_id: a.orgao.id)
    end
    @incomp = Derivado.all.select{|d| d.impacto.nil?}
    @incomp.each do |i|
        i.impacto = i.aprovacao*i.participacao - ((1-i.aprovacao)*i.participacao)
        i.imp_periodo = i.aprov_periodo*i.part_periodo - ((1-i.aprov_periodo)*i.part_periodo)
        i.save
    end
end

url = "https://www.servicos.gov.br/api/v1/servicos"
rascunho = URI.open(url).read
servicos = JSON.parse(rascunho)

artigos = {"Ministério": "o", "Agência": "a", "Instituto": "o", "Universidade": "a", "Fundação": "a", "Superintendência": "a", "Conselho": "o", "Secretaria": "a", "Fundo": "o", "Banco": "o", "Empresa": "a", "Companhia": "a", "Colégio": "o", "Centro": "o", "Hospital": "o", "Comando": "o", "Departamento": "o", "Presidência": "a", "Casa": "a", "Serviço": "o", "Escola": "a", "Câmara": "a", "Advocacia": "a", "Controladoria": "a", "Defensoria": "a"}
ids = []
n = Tempo.all.sort_by{|t| t.order}.last.order
@data = Tempo.new(data: Time.now.to_date, order: n + 1)
@data.save
servicos["resposta"].each do |s|
    if Orgao.find_by(siorg:s["orgao"]["id"].gsub("http://estruturaorganizacional.dados.gov.br/id/unidade-organizacional/", "")).nil?
        @org = Orgao.new({nome:s["orgao"]["nomeOrgao"], nome_fantasia:s["orgao"]["nomeOrgao"], siorg:s["orgao"]["id"].gsub("http://estruturaorganizacional.dados.gov.br/id/unidade-organizacional/", "")})
        artigos.each do |k, e|
            if s["orgao"]["nomeOrgao"].start_with?(k.to_s)
                @org.artigo = e.to_s
            end
        end
        @org.save
    end
    if Servico.find_by(api_id:s["id"].gsub("https://servicos.gov.br/api/v1/servicos/", "")).nil?
        @serv = Servico.new(nome:s["nome"], api_id:s["id"].gsub("https://servicos.gov.br/api/v1/servicos/", ""), orgao_id:Orgao.find_by(nome:s["orgao"]["nomeOrgao"]).id, status:"Novo")
        @serv.save
    else
        @serv = Servico.find_by(api_id:s["id"].gsub("https://servicos.gov.br/api/v1/servicos/", ""))
        @serv.status = "Mantido"
        @serv.save
    end
    if s["avaliacoes"].nil? == false
        @aval = Avaliaco.new(tempo_id:@data.id, servico_id:@serv.id, positivas:s["avaliacoes"]["positivas"], negativas:s["avaliacoes"]["negativas"], total:s["avaliacoes"]["positivas"] + s["avaliacoes"]["negativas"])
        @ant = Avaliaco.find_by(servico_id:@serv.id, tempo_id:Tempo.find_by(order: n).id)
        if @ant.nil?
            @aval.pos_periodo = s["avaliacoes"]["positivas"]
            @aval.neg_periodo = s["avaliacoes"]["negativas"]
            @aval.tot_periodo = s["avaliacoes"]["positivas"] + s["avaliacoes"]["negativas"]
        else
            @aval.pos_periodo = s["avaliacoes"]["positivas"] - @ant.positivas
            @aval.neg_periodo = s["avaliacoes"]["negativas"] - @ant.negativas
            @aval.tot_periodo = (s["avaliacoes"]["positivas"] + s["avaliacoes"]["negativas"]) - @ant.total
        end
        @aval.save
    else
        if Avaliaco.find_by(servico_id: @serv.id).nil?
            @aval = Avaliaco.new(tempo_id:@data.id, positivas:0, negativas:0, servico_id:@serv.id)
            @aval.save
        end
    end
    ids << s["id"].gsub("https://servicos.gov.br/api/v1/servicos/", "").to_i
    @dev = Derivado.new(tempo_id:@data.id, orgao_id:Orgao.find_by(nome:s["orgao"]["nomeOrgao"]).id, servico_id:@serv.id, avaliaco_id:@aval.id)
    @dev.save
    @dev.participacao = @aval.total.to_f/@tmps[@dev.tempo_id]
    @dev.aprovacao = @aval.positivas.to_f/(@aval.total == 0 ? 1 : @aval.total)
    @dev.impacto = (@dev.participacao*@dev.aprovacao) - ((1-@dev.aprovacao)*@dev.participacao)
    @dev.part_periodo = @aval.tot_periodo.to_f/@tmpsper[@dev.tempo_id]
    @dev.aprov_periodo = @aval.pos_periodo.to_f/(@aval.tot_periodo == 0 ? 1 : @aval.tot_periodo)
    @dev.imp_periodo = (@dev.part_periodo*@dev.aprov_periodo) - ((1-@dev.aprov_periodo)*@dev.part_periodo)
    @dev.save
end

Servico.all.select{|s| s.status == "Retirado"}.each do |s|
    s.status = "Extinto"
    s.save
end

Servico.all.select{|s| s.status != "Extinto"}.each do |s|
    if ids.include?(s.api_id) == false
        s.status = "Retirado"
        s.save
    end
end

Avaliaco.all.each do |a|
    if Servico.find(a.servico_id).status == "Retirado" || Servico.find(a.servico_id).status == "Extinto"
        a.atual = false
        a.save
    else
        a.atual = true
        a.save
    end
end

Derivado.all.each do |d|
    if Servico.find(d.servico_id).status == "Retirado" || Servico.find(d.servico_id).status == "Extinto"
        d.atual = false
        d.save
    else
        d.atual = true
        d.save
    end
end