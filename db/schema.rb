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

ActiveRecord::Schema.define(version: 2021_02_28_172231) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "peticiones", force: :cascade do |t|
    t.string "nombre_trabajador"
    t.string "apellido_materno"
    t.string "apellido_paterno"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "empresa_solicitante"
    t.string "persona_solicitante"
    t.string "movimiento"
    t.date "fecha_nacimiento"
    t.text "domicilio"
    t.string "numero_imss"
    t.string "salario_integrado"
    t.string "curp"
    t.string "salario_sin_integrar"
    t.string "rfc"
    t.date "fecha_para_realizar_tramite"
    t.text "observaciones"
    t.integer "folio"
  end

  create_table "users", force: :cascade do |t|
    t.string "nombre_usuario"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "password_digest"
    t.boolean "admin", default: false
  end

end
