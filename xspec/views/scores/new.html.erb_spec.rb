require 'rails_helper'

RSpec.describe 'scores/new', type: :view do
  before(:each) do
    assign(:score, Score.new(
                     score: 1,
                     drop: false,
                     note: 'MyText',
                     user: nil,
                     assessment: nil,
                     strand: nil
    ))
  end

  it 'renders new score form' do
    render

    assert_select 'form[action=?][method=?]', scores_path, 'post' do
      assert_select 'input#score_score[name=?]', 'score[score]'

      assert_select 'input#score_drop[name=?]', 'score[drop]'

      assert_select 'textarea#score_note[name=?]', 'score[note]'

      assert_select 'input#score_user_id[name=?]', 'score[user_id]'

      assert_select 'input#score_assessment_id[name=?]', 'score[assessment_id]'

      assert_select 'input#score_strand_id[name=?]', 'score[strand_id]'
    end
  end
end
