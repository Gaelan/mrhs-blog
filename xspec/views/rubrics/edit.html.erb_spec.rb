require 'rails_helper'

RSpec.describe 'rubrics/edit', type: :view do
  before(:each) do
    @rubric = assign(:rubric, Rubric.create!(
                                level: 1,
                                band: 'MyString',
                                criterion: 'MyText',
                                strand: nil
    ))
  end

  it 'renders the edit rubric form' do
    render

    assert_select 'form[action=?][method=?]', rubric_path(@rubric), 'post' do
      assert_select 'input#rubric_level[name=?]', 'rubric[level]'

      assert_select 'input#rubric_band[name=?]', 'rubric[band]'

      assert_select 'textarea#rubric_criterion[name=?]', 'rubric[criterion]'

      assert_select 'input#rubric_strand_id[name=?]', 'rubric[strand_id]'
    end
  end
end
