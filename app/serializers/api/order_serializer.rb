class Api::OrderSerializer < ApiSerializer

  attributes :id

  def index
    [:name, :email, :last_name, :phone, :address, :city, :comment, :data, :status, :created_at, :discount, :summ, :number, :shipping_method, :payment_method]
  end

  def update
    [:status]
  end

  def data
    ActiveSupport::JSON.decode(object.data)
  end

  def number
    object.number ? "#{object.created_at.strftime("%Y%m%d")}-#{sprintf '%03d', object.number}" : nil
  end

  def summ
    JSON.parse(object.data).map{|e| e["amount"].to_i * e["price"].to_f}.inject{|sum,x| sum + x }
  end

  def shipping_method
    serialize_object object.shipping_method, Api::ShippingMethodSerializer, {scope: :index}
  end

  def payment_method
    serialize_object object.payment_method, Api::PaymentMethodSerializer, {scope: :index}
  end
end

