class Room < ApplicationRecord
  has_many :issues, dependent: :destroy
  before_create :set_slug_and_token

  private

  def set_slug_and_token
    self.slug = SecureRandom.alphanumeric(6).downcase
    self.admin_token = SecureRandom.hex(16)
  end
end
