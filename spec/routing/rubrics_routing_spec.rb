require "rails_helper"

RSpec.describe RubricsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/rubrics").to route_to("rubrics#index")
    end

    it "routes to #new" do
      expect(:get => "/rubrics/new").to route_to("rubrics#new")
    end

    it "routes to #show" do
      expect(:get => "/rubrics/1").to route_to("rubrics#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/rubrics/1/edit").to route_to("rubrics#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/rubrics").to route_to("rubrics#create")
    end

    it "routes to #update" do
      expect(:put => "/rubrics/1").to route_to("rubrics#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/rubrics/1").to route_to("rubrics#destroy", :id => "1")
    end

  end
end
