class Artist < ApplicationRecord
  has_many :songs

  validates :name, presence: true, uniqueness: true
  validates :bio, presence: true
end
