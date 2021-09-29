class Proposal < ApplicationRecord
  has_many :options, dependent: :destroy
  accepts_nested_attributes_for :options
  belongs_to :election
  validates :name, :description, presence: true
end
