class Game < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :release, presence: true
  has_many :game_developers
  has_many :developers, through: :game_developers
end
