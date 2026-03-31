class OrderService
  def self.create(params)
    order = Order.find_by(external_id: params[:external_id])
    return [order, :conflict] if order

    order = Order.create!(
      external_id: params[:external_id],
      payload: params[:payload],
      status: "pending"
    )

    [order, :created]
  rescue ActiveRecord::RecordNotUnique
    [nil, :conflict]
  end
end