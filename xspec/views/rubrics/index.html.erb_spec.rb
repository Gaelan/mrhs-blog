require 'rails_helper'

RSpec.describe 'rubrics/index', type: :view do
  before(:each) do
    assign(:rubrics, [
             Rubric.create!(
               level: 1,
               band: 'Band',
               criterion: 'MyText',
               strand: nil
             ),
             Rubric.create!(
               level: 1,
               band: 'Band',
               criterion: 'MyText',
               strand: nil
             )
           ])
  end

  it 'renders a list of rubrics' do
    render
    assert_select 'tr>td', text: 1.to_s, count: 2
    assert_select 'tr>td', text: 'Band'.to_s, count: 2
    assert_select 'tr>td', text: 'MyText'.to_s, count: 2
    assert_select 'tr>td', text: nil.to_s, count: 2
  end
end
