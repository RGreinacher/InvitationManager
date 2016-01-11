require 'rails_helper'

RSpec.describe "Presents", type: :request do
  describe "GET /presents" do
    it "works! (now write some real specs)" do
      get presents_path
      expect(response).to have_http_status(200)
    end
  end
end
