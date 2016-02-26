require 'rails_helper'

RSpec.describe "Rubrics", :type => :request do
  describe "GET /rubrics" do
    it "works! (now write some real specs)" do
      get rubrics_path
      expect(response).to have_http_status(200)
    end
  end
end
