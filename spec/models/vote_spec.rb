require 'rails_helper'

RSpec.describe Vote, type: :model do
  it 'has a valid factory' do
    expect(build(:vote)).to be_valid
  end

  describe 'associations' do
    it { is_expected.to belong_to :option }
  end
end