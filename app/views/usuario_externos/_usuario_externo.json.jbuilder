json.extract! usuario_externo, :id, :nombre_usuario, :password_digest, :created_at, :updated_at
json.url usuario_externo_url(usuario_externo, format: :json)
