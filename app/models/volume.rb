class Volume < ApplicationRecord
  belongs_to :manga
  has_many :chapters
end
