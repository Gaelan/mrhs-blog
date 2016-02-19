require 'rails_helper'

RSpec.describe "objectives/new", :type => :view do
  before(:each) do
    assign(:objective, Objective.new(
      :group => "MyString",
      :name => "MyString",
      :description => "MyText"
    ))
  end

  it "renders new objective form" do
    render

    assert_select "form[action=?][method=?]", objectives_path, "post" do

      assert_select "input#objective_group[name=?]", "objective[group]"

      assert_select "input#objective_name[name=?]", "objective[name]"

      assert_select "textarea#objective_description[name=?]", "objective[description]"
    end
  end
end
