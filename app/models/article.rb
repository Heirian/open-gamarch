class Article < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true, length: { minimum: 5, maximum: 5000 }

  belongs_to :user
  validates :user_id, presence: true

  default_scope -> { order(updated_at: :desc) }

  has_many :comments, dependent: :destroy

  mount_uploader :image, ImageUploader

  def self.true_image
    self if :image
  end
end
