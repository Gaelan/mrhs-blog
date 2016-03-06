require 'rails_helper'

RSpec.describe Assessment, type: :model do
  it 'correctly detects an invalid assessment' do
    assessment = Assessment.new
    expect(assessment).not_to be_valid

    assessment = Assessment.new
  end

  describe 'validation' do
    it 'fails without a section' do
      assessment = Assessment.new(tasks: [Task.create])
      expect(assessment).not_to be_valid
    end

    it 'fails without tasks' do
      assessment = Assessment.new(section: Section.create)
      expect(assessment).not_to be_valid
    end

    it 'succeeds with a section and tasks' do
      assessment = Assessment.new(section: Section.create, tasks: [Task.create])
      expect(assessment).to be_valid
    end
  end

  pending "test rubric and rubric? method in #{__FILE__}"
end
