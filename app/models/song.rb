class Song < ApplicationRecord

  # validates :name, uniqueness: true, presence: true
  # validates :guid, uniqueness: true, presence: true

  belongs_to :artist

end
