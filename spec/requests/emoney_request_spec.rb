require 'rails_helper'

RSpec.describe "Emoneys", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/emoney/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/emoney/show"
      expect(response).to have_http_status(:success)
    end
  end

end
