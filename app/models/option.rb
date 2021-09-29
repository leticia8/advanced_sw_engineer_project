class Option < ApplicationRecord
  has_many :votes, dependent: :destroy
  belongs_to :proposal

  validates :description, presence: true
end
