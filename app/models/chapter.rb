class Chapter < ApplicationRecord
  belongs_to :manga
  belongs_to :volume, optional: true
  has_many :pages
end
