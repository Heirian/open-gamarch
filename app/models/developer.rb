class Developer < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :founded, presence: true

end
