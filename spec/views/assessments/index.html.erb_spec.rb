require 'rails_helper'

RSpec.describe "assessments/index", :type => :view do
  before(:each) do
    assign(:assessments, [
      Assessment.create!(
        :value => 1,
        :weight => 2,
        :autoscore => 3,
        :title => "Title",
        :category => 4,
        :section => nil
      ),
      Assessment.create!(
        :value => 1,
        :weight => 2,
        :autoscore => 3,
        :title => "Title",
        :category => 4,
        :section => nil
      )
    ])
  end

  it "renders a list of assessments" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
