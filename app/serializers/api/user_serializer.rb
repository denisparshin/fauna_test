class Api::UserSerializer < ApiSerializer
	
  attributes :id, :email, :first_name, :last_name, :username, :discount, :phone, :city, :address
  
  def index
    [:email, :first_name, :last_name, :username, :discount, :phone, :city, :address]
  end

end