require 'rails_helper'

RSpec.describe Enrollment, :type => :model do
  describe 'validation' do
    it 'fails without a section' do
      enrollment = Fabricate.build(:enrollment, section: nil)
      expect(enrollment).not_to be_valid
    end

    it 'fails without a student' do
      enrollment = Fabricate.build(:enrollment, student: nil)
      expect(enrollment).not_to be_valid
    end

    it 'succeeds with a section and student' do
      enrollment = Fabricate.build(:enrollment)
      expect(enrollment).to be_valid
    end
  end
end
