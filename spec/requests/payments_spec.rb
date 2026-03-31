require 'rails_helper'

RSpec.describe "Payments API", type: :request do
  let(:order) { Order.create!(external_id: "order_1") }

  it "creates payment with idempotency key" do
    post "/orders/#{order.id}/payments",
      headers: { "Idempotency-Key" => "abc123" }

    expect(response).to have_http_status(:accepted)
  end

  it "prevents duplicate payment with same key" do
    post "/orders/#{order.id}/payments",
      headers: { "Idempotency-Key" => "abc123" }

    post "/orders/#{order.id}/payments",
      headers: { "Idempotency-Key" => "abc123" }

    expect(Payment.count).to eq(1)
  end

  it "creates new payment with different key" do
    post "/orders/#{order.id}/payments",
      headers: { "Idempotency-Key" => "abc123" }

    post "/orders/#{order.id}/payments",
      headers: { "Idempotency-Key" => "xyz456" }

    expect(Payment.count).to eq(2)
  end
end