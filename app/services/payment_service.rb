class PaymentService
  def self.create(order, params, key)
    return [nil, :bad_request] if key.blank?

    existing = Payment.find_by(idempotency_key: key)
    return [existing, :ok] if existing

    return [nil, :bad_request] if order.cancelled?

    payment = Payment.create!(
      order: order,
      status: "pending",
      idempotency_key: key,
      details: params[:details]
    )

    ProcessPaymentJob.perform_later(payment.id)

    [payment, :accepted]
  rescue ActiveRecord::RecordNotUnique
    [nil, :conflict]
  end
end