class ProcessPaymentJob < ApplicationJob
  queue_as :default

  retry_on StandardError, attempts: 3, wait: :exponentially_longer

  def perform(payment_id)
    payment = Payment.find(payment_id)

    return if payment.completed? || payment.cancelled?
    return if payment.order.cancelled?

    payment.with_lock do
      payment.update!(status: "processing")
    end

    sleep 3

    if rand < 0.7
      payment.update!(status: "completed")
    else
      raise "Gateway failure"
    end

  rescue => e
    payment.increment!(:retry_count)
    payment.update!(status: "failed", error_message: e.message)

    raise e
  end
end