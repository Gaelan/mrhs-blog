require 'rails_helper'

RSpec.describe CourseObjective, type: :model do
  describe 'validation' do
    it 'fails without a course' do
      course_objective = Fabricate.build(:course_objective, course: nil)
      expect(course_objective).not_to be_valid
    end

    it 'fails without a objective' do
      course_objective = Fabricate.build(:course_objective, objective: nil)
      expect(course_objective).not_to be_valid
    end

    it 'succeeds with a course and objective' do
      course_objective = Fabricate.build(:course_objective)
      expect(course_objective).to be_valid
    end
  end
  # pending "add some examples to (or delete) #{__FILE__}"
end
