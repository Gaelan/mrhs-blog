require 'rails_helper'

RSpec.describe "assessments/show", :type => :view do
  before(:each) do
    @assessment = assign(:assessment, Assessment.create!(
      :value => 1,
      :weight => 2,
      :autoscore => 3,
      :title => "Title",
      :category => 4,
      :section => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(//)
  end
end
