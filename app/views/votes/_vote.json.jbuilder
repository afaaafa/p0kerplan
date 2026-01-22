json.extract! vote, :id, :issue_id, :participant_id, :participant_name, :value, :created_at, :updated_at
json.url vote_url(vote, format: :json)
