require 'rails_helper'

RSpec.describe Score, type: :model do
  let(:strand) { Strand.create }
  let(:user) { User.create }
  let(:assessment) { Assessment.create }
  let(:post) { Post.create }
  it 'does not find a score where there is not one yet' do
    expect(Score.for(post: post, strand: strand, user: user, assessment: assessment)).not_to be_persisted
  end

  it 'gets the score where there already is one' do
    Score.create(post: post, strand: strand, user: user, assessment: assessment, score: 5)

    expect(Score.for(post: post, strand: strand, user: user, assessment: assessment)).to be_persisted
  end
end
