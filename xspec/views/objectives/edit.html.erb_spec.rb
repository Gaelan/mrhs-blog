require 'rails_helper'

RSpec.describe 'objectives/edit', type: :view do
  before(:each) do
    @objective = assign(:objective, Objective.create!(
                                      group: 'MyString',
                                      name: 'MyString',
                                      description: 'MyText'
    ))
  end

  it 'renders the edit objective form' do
    render

    assert_select 'form[action=?][method=?]', objective_path(@objective), 'post' do
      assert_select 'input#objective_group[name=?]', 'objective[group]'

      assert_select 'input#objective_name[name=?]', 'objective[name]'

      assert_select 'textarea#objective_description[name=?]', 'objective[description]'
    end
  end
end
