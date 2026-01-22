json.extract! issue, :id, :title, :status, :description, :room_id, :created_at, :updated_at
json.url issue_url(issue, format: :json)
