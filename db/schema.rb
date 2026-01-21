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

ActiveRecord::Schema[8.1].define(version: 2026_01_21_052304) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "personas", force: :cascade do |t|
    t.string "correo"
    t.datetime "created_at", null: false
    t.string "nombre"
    t.string "telefono_principal"
    t.string "telefono_secundario"
    t.bigint "tipo_persona_id", null: false
    t.datetime "updated_at", null: false
    t.index ["tipo_persona_id"], name: "index_personas_on_tipo_persona_id"
  end

  create_table "tipo_documentos", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "documento"
    t.datetime "updated_at", null: false
  end

  create_table "tipo_personas", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "tipo"
    t.datetime "updated_at", null: false
  end

  create_table "usuarios", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.date "fecha_emision"
    t.date "fecha_vencimiento"
    t.string "n_documento"
    t.bigint "persona_id", null: false
    t.bigint "tipo_documento_id", null: false
    t.datetime "updated_at", null: false
    t.index ["persona_id"], name: "index_usuarios_on_persona_id"
    t.index ["tipo_documento_id"], name: "index_usuarios_on_tipo_documento_id"
  end

  add_foreign_key "personas", "tipo_personas"
  add_foreign_key "usuarios", "personas"
  add_foreign_key "usuarios", "tipo_documentos"
end
