require 'rails_helper'

RSpec.describe Rubric, type: :model do
  describe 'validation' do
    it 'fails without a level' do
      rubric = Rubric.new(band: '7-8', criterion: 'Do good work.')
      expect(rubric).not_to be_valid
    end

    it 'fails without a criterion' do
      rubric = Rubric.new(band: '7-8', level: :unit)
      expect(rubric).not_to be_valid
    end

    it 'fails without a band' do
      rubric = Rubric.new(criterion: 'Do good work.', level: :unit)
      expect(rubric).not_to be_valid
    end

    it 'succeeds with a band, criterion, and level' do
      rubric = Rubric.new(band: '7-8', criterion: 'Do good work.', level: :unit)
      expect(rubric).to be_valid
    end
  end
end
