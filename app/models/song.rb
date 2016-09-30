class Song < ApplicationRecord

  validates :name, presence: true
  validates :guid, uniqueness: true, presence: true

end
