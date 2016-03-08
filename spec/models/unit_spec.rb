require 'rails_helper'

RSpec.describe Unit, type: :model do
  pending "validate summative assessment #{__FILE__}"

  describe 'validation' do
    it 'fails when uninitailized' do
      unit = Unit.new
      expect(unit).not_to be_valid
    end
    it 'fails without a title' do
      unit = Unit.new(duration: 0)
      expect(unit).not_to be_valid
    end
    it 'fails if title is too short' do
      unit = Unit.new(
        duration: 0,
        title: 'Fun'
      )
      expect(unit).not_to be_valid
    end
    it 'fails if title is too long' do
      unit = Unit.new(
        duration: 0,
        title: 'Make a photo essay about an idea or experiement, or something, that makes you very happy or very angry'
      )
      expect(unit).not_to be_valid
    end
    it 'fails if duration is too short' do
      unit = Unit.new(
        duration: 0,
        title: 'What do artists do?'
      )
      expect(unit).not_to be_valid
    end
    it 'fails if duration is too long' do
      unit = Unit.new(
        duration: 1000,
        title: 'What do artists do?'
      )
      expect(unit).not_to be_valid
    end
    it 'succeeds with proper title and nil duration' do
      unit = Unit.new(
        duration: nil,
        title: 'What do artists do?'
      )
      expect(unit).to be_valid
    end
    it 'succeeds with proper title and reasonable duration' do
      unit = Unit.new(
        duration: 20,
        title: 'What do artists do?'
      )
      expect(unit).to be_valid
    end
  end
end
