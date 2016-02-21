require 'rails_helper'

RSpec.describe "units/edit", :type => :view do
  before(:each) do
    @unit = assign(:unit, Unit.create!(
      :title => "MyString",
      :soi => "MyText",
      :duration => 1
    ))
  end

  it "renders the edit unit form" do
    render

    assert_select "form[action=?][method=?]", unit_path(@unit), "post" do

      assert_select "input#unit_title[name=?]", "unit[title]"

      assert_select "textarea#unit_soi[name=?]", "unit[soi]"

      assert_select "input#unit_duration[name=?]", "unit[duration]"
    end
  end
end
