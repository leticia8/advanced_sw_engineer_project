require 'rails_helper'

RSpec.describe Option, type: :model do
  it 'has a valid factory' do
    expect(build(:option)).to be_valid
  end

  describe 'associations' do
    it { is_expected.to belong_to :proposal }
    it { is_expected.to have_many :votes }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:description) }
  end
end