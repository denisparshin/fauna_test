class ShippingMethod < ActiveRecord::Base
  has_many :orders, dependent: :destroy
end
