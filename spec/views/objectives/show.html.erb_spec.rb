require 'rails_helper'

RSpec.describe "objectives/show", :type => :view do
  before(:each) do
    @objective = assign(:objective, Objective.create!(
      :group => "Group",
      :name => "Name",
      :description => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Group/)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/MyText/)
  end
end
