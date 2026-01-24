class Participant < ApplicationRecord
  belongs_to :room

  after_create_commit -> { broadcast_append_to room, target: "participants-list" }
end
