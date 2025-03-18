class Decision < ApplicationRecord
  validates :chapter, presence: true
  validates :name, presence: true
  validates :date, presence: true
  validates :summary, presence: true
end
