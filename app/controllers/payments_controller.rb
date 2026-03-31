class PaymentsController < ApplicationController
  def create
    order = Order.find(params[:order_id])
    key = request.headers["Idempotency-Key"]

    payment, status = PaymentService.create(order, payment_params, key)

    if payment
      render json: payment, status: status
    else
      render json: { error: "Request failed" }, status: status
    end
  end

  def destroy
    payment = Payment.find(params[:id])
    payment.update!(status: "cancelled")

    render json: { message: "Payment cancelled" }, status: :ok
  end

  private

  def payment_params
    params.permit(details: {})
  end
end