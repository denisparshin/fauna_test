class Api::PaymentMethodSerializer < ApiSerializer
  
    attributes :id, :name, :description


  def index
    [:name, :description]
  end

  def show
    [:name, :description, :id]
  end

end


