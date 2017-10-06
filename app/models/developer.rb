class Developer < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :founded, presence: true
  has_many :game_developers
  has_many :games, through: :game_developers
end
