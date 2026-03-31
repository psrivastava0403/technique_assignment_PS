class OrdersController < ApplicationController
  def create
    order, status = OrderService.create(order_params)

    if order
      render json: order, status: status
    else
      render json: { error: "Order already exists" }, status: status
    end
  end

  def destroy
    order = Order.find(params[:id])
    order.update!(status: "cancelled")

    render json: { message: "Order cancelled" }, status: :ok
  end

  private

  def order_params
    params.permit(:external_id, payload: {})
  end
end