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

    it 'fails with a section and multiple tasks' do
      assessment = Fabricate.build(:assessment)
      expect(assessment).not_to be_valid
    end

    it 'succeeds with a section and one task' do
      assessment = Fabricate.build(:assessment, tasks: [Task.create])
      expect(assessment).to be_valid
    end
  end

  describe 'scoreable' do
    let!(:user1) { User.create }
    let(:user2) { User.create }
    let(:assessment1) do
      Assessment.create(
        section: Section.create,
        tasks: [Task.create],
        due_date: Time.current
      )
    end
    let(:assessment2) do
      Assessment.create(
        section: Section.create,
        tasks: [Task.create],
        due_date: Time.current
      )
    end
    let!(:posts) do
      [
        Post.create(
          user_id: user1,
          published: true,
          assessment_id: assessment1.id
        ),
        Post.create(
          user_id: user2.id,
          published: false,
          assessment_id: assessment2.id
        )
      ]
    end

    it 'returns an array of Posts' do
      # TODO: how should this actually be checked?
      expect(assessment1.scoreable[0]).to be_a(Post)
    end

    it 'finds scoreable instances of Post' do
      expect(assessment1.scoreable).to eq([posts[0]])
    end

    pending "to return an empty array when there are no posts in #{__FILE__}"
    pending "to return an empty array when the due date has not passed and there are no published posts in #{__FILE__}"
    pending "to return an array of posts when the due date has passed and some are marked published in #{__FILE__}"
    pending "to generate automatic scores in #{__FILE__}"
  end

  pending "test rubric and rubric? method in #{__FILE__}"
  pending "test to_s method in #{__FILE__}"
  pending "test updated? method in #{__FILE__}"
end
