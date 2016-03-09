require 'rails_helper'

RSpec.describe 'assessments/new', type: :view do
  before(:each) do
    assign(:assessment, Assessment.new(
                          value: 1,
                          weight: 1,
                          autoscore: 1,
                          title: 'MyString',
                          category: 1,
                          section: nil
    ))
  end

  it 'renders new assessment form' do
    render

    assert_select 'form[action=?][method=?]', assessments_path, 'post' do
      assert_select 'input#assessment_value[name=?]', 'assessment[value]'

      assert_select 'input#assessment_weight[name=?]', 'assessment[weight]'

      assert_select 'input#assessment_autoscore[name=?]', 'assessment[autoscore]'

      assert_select 'input#assessment_title[name=?]', 'assessment[title]'

      assert_select 'input#assessment_category[name=?]', 'assessment[category]'

      assert_select 'input#assessment_section_id[name=?]', 'assessment[section_id]'
    end
  end
end
