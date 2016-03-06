require 'rails_helper'

RSpec.describe "rubrics/show", :type => :view do
  before(:each) do
    @rubric = assign(:rubric, Rubric.create!(
      :level => 1,
      :band => "Band",
      :criterion => "MyText",
      :strand => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Band/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(//)
  end
end
