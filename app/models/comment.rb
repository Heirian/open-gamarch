class Comment < ApplicationRecord
  validates :description, presence: true, length: { maximum: 500 }
  belongs_to :user
  belongs_to :article
  validates :user_id, presence: true
  validates :article_id, presence: true
  default_scope -> { order(updated_at: :desc) }
end
