require 'rails_helper'

RSpec.describe "Payments", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/payment/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/payment/create"
      expect(response).to have_http_status(:success)
    end
  end

end
