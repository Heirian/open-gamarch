class GameDeveloper < ApplicationRecord
  belongs_to :developer
  belongs_to :game
end
