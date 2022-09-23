# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_09_20_122134) do
  create_table "avaliacos", force: :cascade do |t|
    t.integer "positivas"
    t.integer "negativas"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "servico_id"
    t.integer "total"
    t.integer "tempo_id"
    t.integer "pos_periodo"
    t.integer "neg_periodo"
    t.integer "tot_periodo"
    t.index ["servico_id"], name: "index_avaliacos_on_servico_id"
    t.index ["tempo_id"], name: "index_avaliacos_on_tempo_id"
  end

  create_table "derivados", force: :cascade do |t|
    t.float "aprovacao"
    t.float "participacao"
    t.float "impacto"
    t.float "aprov_periodo"
    t.float "part_periodo"
    t.float "imp_periodo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "avaliaco_id"
    t.integer "servico_id"
    t.integer "orgao_id"
    t.integer "tempo_id"
    t.index ["avaliaco_id"], name: "index_derivados_on_avaliaco_id"
    t.index ["orgao_id"], name: "index_derivados_on_orgao_id"
    t.index ["servico_id"], name: "index_derivados_on_servico_id"
    t.index ["tempo_id"], name: "index_derivados_on_tempo_id"
  end

  create_table "orgaos", force: :cascade do |t|
    t.string "nome"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "nome_fantasia"
    t.string "artigo"
  end

  create_table "servicos", force: :cascade do |t|
    t.integer "api_id"
    t.string "nome"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status"
    t.integer "orgao_id"
    t.index ["orgao_id"], name: "index_servicos_on_orgao_id"
  end

  create_table "tempos", force: :cascade do |t|
    t.date "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "order"
  end

end
