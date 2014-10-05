require 'rails_helper'

RSpec.describe "Menus", :type => :request do
  describe "GET /menus" do
    it "works! (now write some real specs)" do
      get menus_path
      expect(response.status).to be(200)
    end
  end
end
