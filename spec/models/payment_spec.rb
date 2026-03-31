require 'rails_helper'

RSpec.describe Payment, type: :model do
  let(:order) { Order.create!(external_id: "order_1") }

  it "is valid with idempotency_key" do
    payment = Payment.new(order: order, idempotency_key: "abc")
    expect(payment).to be_valid
  end

  it "does not allow duplicate idempotency_key" do
    Payment.create!(order: order, idempotency_key: "abc")
    duplicate = Payment.new(order: order, idempotency_key: "abc")
    expect(duplicate).not_to be_valid
  end
end