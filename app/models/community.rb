class Community < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  belongs_to :user
  validates :user_id, presence: true
  belongs_to :game
end
