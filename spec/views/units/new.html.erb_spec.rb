require 'rails_helper'

RSpec.describe 'units/new', type: :view do
  before(:each) do
    assign(:unit, Unit.new(
                    title: 'MyString',
                    soi: 'MyText',
                    duration: 1
    ))
  end

  it 'renders new unit form' do
    render

    assert_select 'form[action=?][method=?]', units_path, 'post' do
      assert_select 'input#unit_title[name=?]', 'unit[title]'

      assert_select 'textarea#unit_soi[name=?]', 'unit[soi]'

      assert_select 'input#unit_duration[name=?]', 'unit[duration]'
    end
  end
end
