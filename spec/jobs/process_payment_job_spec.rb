require 'rails_helper'

RSpec.describe ProcessPaymentJob, type: :job do
  let(:order) { Order.create!(external_id: "order_1") }
  let(:payment) { Payment.create!(order: order, idempotency_key: "abc") }

  it "updates payment status" do
    ProcessPaymentJob.perform_now(payment.id)

    payment.reload
    expect(["completed", "failed"]).to include(payment.status)
  end
end