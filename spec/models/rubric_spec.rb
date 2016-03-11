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

  describe 'verify_level' do
    it 'sets rubricable to nil if level does not match rubricable' do
      task = Task.create
      rubric = Fabricate.build(:rubric,
                               level: :unit,
                               rubricable: task
                              #  rubricable_type: Task,
                              #  rubricable_id: 1
                              )
      rubric.verify_level
      expect(rubric.rubricable).to be_nil
    end
    it 'preserves rubricable when level matches rubricable' do
      task = Task.create
      rubric = Fabricate.build(:rubric,
                               level: :task,
                               rubricable: task
                              #  rubricable_type: Task,
                              #  rubricable_id: 1
                              )
      rubric.verify_level
      expect(rubric.rubricable).not_to be_nil # XXX - should equal task
    end
  end
end
