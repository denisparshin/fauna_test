class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :shipping_method
  belongs_to :payment_method
  enum status: {
    created:     0,
    in_progress: 1,
    sent:        2,
    aproved:     3,
    declined:    4,
    waiting:     5,
  }
  scope :date_from, -> (date_from) { where("created_at >= ?", Time.parse(date_from)) if date_from.presence }
  scope :date_to, -> (date_to) { where("created_at <= ?", Time.parse(date_to)) if date_to.presence }
  scope :with_status, -> (status) { where(status: Order.statuses[status]) if status }

  scope :index, -> (search) {
    includes(:shipping_method, :payment_method)
    .date_from(search.date_from)
    .date_to(search.date_to)
    .with_status(search.status)
    .order(created_at: :desc)
  }

  def order_data
    ActiveSupport::JSON.decode self.data
  end

  def summ
    self.order_data.map{|o| o["price"] * o["amount"] }.inject(0){|sum,x| sum + x}
  end

  scope :all_summ, -> (from=Time.now, to=30.days.ago, status=3) { where("created_at > ?", to).where("created_at < ?", from).where(status: status).map{|o| ActiveSupport::JSON.decode(o[:data]).map{|i| i["price"].to_f * i["amount"].to_i }.inject(0){|sum,x| sum + x } }.inject(0){|sum,x| sum + x }  }
end
