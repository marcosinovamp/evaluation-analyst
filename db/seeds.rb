# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require "json"
require "open-uri"

url = "https://www.servicos.gov.br/api/v1/servicos"
rascunho = URI.open(url).read
servicos = JSON.parse(rascunho)

ids = []
orgaos = []
@data = Data.new(data: Time.now.to_date)
@data.save
servicos["resposta"].each do |s|
    if Servico.find_by(api_id: s["id"].gsub("https://servicos.gov.br/api/v1/servicos/", "")).nil?
        @serv = Servico.new(nome: s["nome"], api_id: s["id"].gsub("https://servicos.gov.br/api/v1/servicos/", ""), orgao: s["orgao"]["nomeOrgao"], status: "Novo")
        @serv.save
    else
        @serv = Servico.find_by(api_id: s["id"].gsub("https://servicos.gov.br/api/v1/servicos/", ""))
        @serv.status = "Mantido"
        @serv.save
    end
    if s["avaliacoes"].nil? == false
        @aval = Avaliaco.new(tempo_id: @data.id, positivas: s["avaliacoes"]["positivas"], negativas: s["avaliacoes"]["negativas"], servico_id: @serv.id, total: s["avaliacoes"]["positivas"] + s["avaliacoes"]["negativas"], aprov: s["avaliacoes"]["positivas"].to_f/(s["avaliacoes"]["positivas"] + s["avaliacoes"]["negativas"]) == 0 ? 1: (s["avaliacoes"]["positivas"] + s["avaliacoes"]["negativas"]))
        @aval.save
    else
        if Avaliaco.find_by(servico_id: @serv.id).nil? || Avaliaco.find_by(servico_id: @serv.id).data.to_date != Time.now.to_date
            @aval = Avaliaco.new(tempo_id: @data.id, positivas: 0, negativas: 0, servico_id: @serv.id)
            @aval.save
        end
    end
    ids << s["id"].gsub("https://servicos.gov.br/api/v1/servicos/", "").to_i
    if orgaos.include?(s["orgao"]["nomeOrgao"]) == false
        orgaos << s["orgao"]["nomeOrgao"]
    end
end

Servico.all.select{|s| s.status == "Retirado"}.each do |s|
        s.status = "Extinto"
        s.save
    end
end

Servico.all.select{|s| s.status != "Extinto"}.each do |s|
    if ids.include?(s.api_id) == false
        s.status = "Retirado"
        s.save
    end
end

orgaos.each do |o|
    Orgao.create[nome: o]
end

# require "csv"

# filepath = "db/aval.csv"
# @fonte = []

# CSV.foreach(filepath) do |row|
#     @fonte << row
# end

# @erros = []

# @fonte.each do |f|
#     if Servico.find_by(api_id: f[0]).nil? == false
#         @jul = Avaliaco.new(data: "2022-07-28".to_datetime, positivas: f[1], negativas: f[2], servico_id: Servico.find_by(api_id: f[0]).id)
#         @ago = Avaliaco.new(data: "2022-08-30".to_datetime, positivas: f[3], negativas: f[4], servico_id: Servico.find_by(api_id: f[0]).id)
#         @set1 = Avaliaco.new(data: "2022-09-06".to_datetime, positivas: f[5], negativas: f[6], servico_id: Servico.find_by(api_id: f[0]).id)
#         @set2 = Avaliaco.new(data: "2022-09-13".to_datetime, positivas: f[7], negativas: f[8], servico_id: Servico.find_by(api_id: f[0]).id)
#         @jul.save
#         @ago.save
#         @set1.save
#         @set2.save
#     else
#         @erros << f
#     end
# end