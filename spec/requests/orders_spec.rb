require 'rails_helper'

RSpec.describe "Orders API", type: :request do
  describe "POST /orders" do
    it "creates a new order" do
      post "/orders", params: { external_id: "order_1" }

      expect(response).to have_http_status(:created)
    end

    it "prevents duplicate orders" do
      Order.create!(external_id: "order_1")

      post "/orders", params: { external_id: "order_1" }

      expect(response).to have_http_status(:conflict)
    end
  end
end