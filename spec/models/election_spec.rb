require 'rails_helper'

RSpec.describe Election, type: :model do
  it 'has a valid factory' do
    expect(build(:election)).to be_valid
  end

  describe 'associations' do
    it { is_expected.to belong_to :user }
    it { is_expected.to have_many :user_elections }
    it { is_expected.to have_many :users_that_vote }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:start_date) }
    it { is_expected.to validate_presence_of(:finish_date) }
    it { is_expected.to validate_presence_of(:segmented_by) }
    it { is_expected.to validate_presence_of(:condition) }
  end
end