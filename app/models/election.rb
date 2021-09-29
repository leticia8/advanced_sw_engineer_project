class Election < ApplicationRecord
  enum segmented_by: [:city, :state, :age]
  has_many :proposals, dependent: :destroy
  accepts_nested_attributes_for :proposals
  belongs_to :user
  has_many :user_elections
  has_many :users_that_vote, through: :user_elections, source: :user

  validates :description, :start_date, :finish_date, :segmented_by, :condition, presence: true
  validate :date_after_today, :start_before_finish

  private

  def date_after_today
    return unless start_date.present? && start_date < Date.current

    error_message = 'Fecha de inicio debe ser posterior a la actual'
    errors.add(:start_date, error_message)
  end

  def start_before_finish
    return unless start_date.present? && finish_date.present? && start_date > finish_date

    error_message = 'Fecha de inicio debe ser anterior a la fecha de fin'
    errors.add(:start_date, error_message)
  end
end
