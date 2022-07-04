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

ActiveRecord::Schema[7.0].define(version: 2022_07_04_152007) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "audits", force: :cascade do |t|
    t.integer "auditable_id"
    t.string "auditable_type"
    t.integer "associated_id"
    t.string "associated_type"
    t.integer "user_id"
    t.string "user_type"
    t.string "username"
    t.string "action"
    t.jsonb "audited_changes"
    t.integer "version", default: 0
    t.string "comment"
    t.string "remote_address"
    t.string "request_uuid"
    t.datetime "created_at", precision: nil
    t.index ["associated_type", "associated_id"], name: "associated_index"
    t.index ["auditable_type", "auditable_id", "version"], name: "auditable_index"
    t.index ["created_at"], name: "index_audits_on_created_at"
    t.index ["request_uuid"], name: "index_audits_on_request_uuid"
    t.index ["user_id", "user_type"], name: "user_index"
  end

  create_table "casos", force: :cascade do |t|
    t.bigint "cliente_id"
    t.text "texto_caso"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "fecha_conclusion"
    t.index ["cliente_id"], name: "index_casos_on_cliente_id"
  end

  create_table "clientes", force: :cascade do |t|
    t.string "razon_social"
    t.string "rfc"
    t.string "num_interno"
    t.string "regimen_fiscal"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "clave"
    t.string "fiel"
    t.string "csd"
    t.date "fiel_vencimiento", default: "2022-06-21"
    t.date "csd_vencimiento", default: "2022-06-21"
    t.bigint "user_id"
    t.index ["user_id"], name: "index_clientes_on_user_id"
  end

  create_table "clientes_replegales", id: false, force: :cascade do |t|
    t.bigint "replegal_id", null: false
    t.bigint "cliente_id", null: false
    t.index ["cliente_id"], name: "index_clientes_replegales_on_cliente_id", unique: true
    t.index ["replegal_id"], name: "index_clientes_replegales_on_replegal_id"
  end

  create_table "egresos", force: :cascade do |t|
    t.text "descripcion"
    t.string "emisor"
    t.decimal "cantidad"
    t.text "notas_adicionales"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.date "fecha"
    t.boolean "iva_acreditable_bool"
  end

  create_table "peticiones", force: :cascade do |t|
    t.string "nombre_trabajador"
    t.string "apellido_materno"
    t.string "apellido_paterno"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.bigint "usuario_externo_id", null: false
    t.index ["usuario_externo_id"], name: "index_peticiones_on_usuario_externo_id"
  end

  create_table "productos", force: :cascade do |t|
    t.string "nombre_producto"
    t.string "clave_sat"
    t.string "precio_1"
    t.string "precio_2"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.date "fecha_de_compra"
    t.integer "cantidad_comprada"
    t.decimal "precio"
    t.text "notas_adicionales"
    t.integer "perdidas"
    t.string "columna_relacionada_en_ventas"
    t.string "precio_3"
    t.string "precio_4"
    t.string "precio_5"
    t.string "precio_6"
    t.string "precio_7"
    t.string "precio_8"
    t.decimal "costo_unitario"
    t.boolean "costo_actual"
  end

  create_table "replegales", force: :cascade do |t|
    t.string "nombre_completo"
    t.string "rfc"
    t.string "clave"
    t.string "fiel"
    t.string "csd"
    t.date "vencimiento_fiel"
    t.date "vencimiento_clave"
    t.date "vencimiento_csd"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "nombre_usuario"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.boolean "admin", default: false
  end

  create_table "usuario_externos", force: :cascade do |t|
    t.string "nombre_usuario"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.boolean "email_confirmado", default: false
    t.string "confirm_token"
  end

  create_table "ventas", force: :cascade do |t|
    t.date "fecha"
    t.integer "longitud_75mm"
    t.integer "longitud_87mm"
    t.integer "longitud_136mm"
    t.integer "cantidad_peltier"
    t.integer "cantidad_pasta_termica"
    t.decimal "precio_75mm"
    t.decimal "precio_87mm"
    t.decimal "precio_136mm"
    t.decimal "precio_peltier"
    t.decimal "precio_pasta_termica"
    t.decimal "subtotal"
    t.decimal "descuento_75mm"
    t.decimal "descuento_87mm"
    t.decimal "descuento_136mm"
    t.decimal "descuento_peltier"
    t.decimal "descuento_pasta_termica"
    t.decimal "total_productos"
    t.decimal "envio_explicito"
    t.decimal "total_pagado_por_cliente"
    t.decimal "comisiones"
    t.decimal "comision_envio"
    t.decimal "total_post_comisiones"
    t.string "medio_de_venta"
    t.boolean "facturado"
    t.string "folio_factura"
    t.text "notas_adicionales"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.integer "cliente_id"
    t.integer "cortes_75mm"
    t.integer "cortes_87mm"
    t.integer "cortes_136mm"
    t.decimal "dinero_anadido"
    t.integer "longitud_28mm"
    t.integer "longitud_50mm"
    t.integer "longitud_100mm"
    t.integer "longitud_220mm"
    t.decimal "precio_28mm"
    t.decimal "precio_50mm"
    t.decimal "precio_100mm"
    t.decimal "precio_220mm"
    t.decimal "descuento_28mm"
    t.decimal "descuento_50mm"
    t.decimal "descuento_100mm"
    t.decimal "descuento_220mm"
    t.integer "cortes_28mm"
    t.integer "cortes_50mm"
    t.integer "cortes_100mm"
    t.integer "cortes_220mm"
    t.decimal "iva_prod"
    t.decimal "iva_envios"
    t.decimal "iva_anadido"
    t.boolean "iva_comision_bool"
    t.boolean "iva_envio_bool"
    t.decimal "costo_28mm"
    t.decimal "costo_50mm"
    t.decimal "costo_75mm"
    t.decimal "costo_87mm"
    t.decimal "costo_100mm"
    t.decimal "costo_136mm"
    t.decimal "costo_220mm"
    t.decimal "costo_peltier"
    t.decimal "costo_pasta_termica"
    t.decimal "longitud_125mm"
    t.decimal "longitud_75mm_anod"
    t.decimal "longitud_87mm_anod"
    t.decimal "precio_125mm"
    t.decimal "precio_75mm_anod"
    t.decimal "precio_87mm_anod"
    t.decimal "descuento_125mm"
    t.decimal "descuento_75mm_anod"
    t.decimal "descuento_87mm_anod"
    t.decimal "cortes_125mm"
    t.decimal "cortes_75mm_anod"
    t.decimal "cortes_87mm_anod"
    t.decimal "costo_125mm"
    t.decimal "costo_75mm_anod"
    t.decimal "costo_87mm_anod"
    t.decimal "longitud_230mm"
    t.decimal "longitud_75mm_negro"
    t.decimal "precio_230mm"
    t.decimal "precio_75mm_negro"
    t.decimal "descuento_230mm"
    t.decimal "descuento_75mm_negro"
    t.decimal "cortes_230mm"
    t.decimal "cortes_75mm_negro"
    t.decimal "costo_230mm"
    t.decimal "costo_75mm_negro"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "casos", "clientes"
  add_foreign_key "clientes", "users"
  add_foreign_key "peticiones", "usuario_externos"
end
