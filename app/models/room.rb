class Room < ApplicationRecord
  has_many :issues, dependent: :destroy
  has_many :participants, dependent: :destroy

  validates :slug, uniqueness: true

  before_create :set_slug_and_token

  def to_param
    slug
  end

  private

  def set_slug_and_token
    self.slug = if slug.blank?
      SecureRandom.hex(8)
    else
      slug.parameterize
    end

    self.admin_token = SecureRandom.hex(16)
  end
end
