require 'rails_helper'

RSpec.describe Assessment, type: :model do
  describe 'validation' do
    it 'fails with no properties' do
      expect(Assessment.new).not_to be_valid
    end

    it 'fails without a section' do
      assessment = Fabricate.build(:assessment, section: nil)
      expect(assessment).not_to be_valid
    end

    it 'fails without tasks' do
      assessment = Fabricate.build(:assessment, tasks: [])
      expect(assessment).not_to be_valid
    end

    it 'succeeds with a section and tasks' do
      assessment = Fabricate.build(:assessment)
      expect(assessment).to be_valid
    end
  end

  pending "test rubric and rubric? method in #{__FILE__}"
end
