require 'rails_helper'

RSpec.describe 'objectives/index', type: :view do
  before(:each) do
    assign(:objectives, [
             Objective.create!(
               group: 'Group',
               name: 'Name',
               description: 'MyText'
             ),
             Objective.create!(
               group: 'Group',
               name: 'Name',
               description: 'MyText'
             )
           ])
  end

  it 'renders a list of objectives' do
    render
    assert_select 'tr>td', text: 'Group'.to_s, count: 2
    assert_select 'tr>td', text: 'Name'.to_s, count: 2
    assert_select 'tr>td', text: 'MyText'.to_s, count: 2
  end
end
