class Manga < ApplicationRecord
  has_many :volumes
  has_many :chapters
  has_one_attached :cover_image
end
