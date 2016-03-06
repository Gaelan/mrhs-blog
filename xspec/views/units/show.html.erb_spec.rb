require 'rails_helper'

RSpec.describe 'units/show', type: :view do
  before(:each) do
    @unit = assign(:unit, Unit.create!(
                            title: 'Title',
                            soi: 'MyText',
                            duration: 1
    ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/1/)
  end
end
