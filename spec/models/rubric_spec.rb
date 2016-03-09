require 'rails_helper'

RSpec.describe Rubric, type: :model do
  describe 'validation' do
    it 'fails without a level' do
      rubric = Fabricate.build(:rubric, level: nil)
      expect(rubric).not_to be_valid
    end

    it 'fails without a criterion' do
      rubric = Fabricate.build(:rubric, criterion: nil)
      expect(rubric).not_to be_valid
    end

    it 'fails without a band' do
      rubric = Fabricate.build(:rubric, band: nil)
      expect(rubric).not_to be_valid
    end

    it 'succeeds with a band, criterion, and level' do
      rubric = Fabricate.build(:rubric)
      expect(rubric).to be_valid
    end
  end
end
