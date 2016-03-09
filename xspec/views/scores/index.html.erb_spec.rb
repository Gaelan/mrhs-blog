require 'rails_helper'

RSpec.describe "scores/index", :type => :view do
  before(:each) do
    assign(:scores, [
      Score.create!(
        :score => 1,
        :drop => false,
        :note => "MyText",
        :user => nil,
        :assessment => nil,
        :strand => nil
      ),
      Score.create!(
        :score => 1,
        :drop => false,
        :note => "MyText",
        :user => nil,
        :assessment => nil,
        :strand => nil
      )
    ])
  end

  it "renders a list of scores" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
