require 'rails_helper'

RSpec.describe Proposal, type: :model do
  it 'has a valid factory' do
    expect(build(:proposal)).to be_valid
  end

  describe 'associations' do
    it { is_expected.to belong_to :election }
    it { is_expected.to have_many :options }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:name) }
  end
end