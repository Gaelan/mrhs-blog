require 'rails_helper'

RSpec.describe Score, type: :model do
  let(:strand) { Strand.create }
  let(:user) { User.create }
  let(:assessment) { Assessment.create }
  it 'gets the score where there is not one yet' do
    expect(Score.for(strand: strand, user: user, assessment: assessment)).not_to be_persisted
  end

  it 'gets the score where there is alerady one' do
    Score.create(strand: strand, user: user, assessment: assessment, score: 5)

    expect(Score.for(strand: strand, user: user, assessment: assessment)).to be_persisted
  end
end
