require 'rails_helper'

RSpec.describe Order, type: :model do
  it "is valid with external_id" do
    order = Order.new(external_id: "order_1")
    expect(order).to be_valid
  end

  it "is invalid without external_id" do
    order = Order.new
    expect(order).not_to be_valid
  end

  it "does not allow duplicate external_id" do
    Order.create!(external_id: "order_1")
    duplicate = Order.new(external_id: "order_1")
    expect(duplicate).not_to be_valid
  end
end