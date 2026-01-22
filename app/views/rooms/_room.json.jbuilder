json.extract! room, :id, :name, :slug, :admin_token, :created_at, :updated_at
json.url room_url(room, format: :json)
