class Metatag < ActiveRecord::Base
  has_many :categories
  has_many :products
  has_many :catalogs
end
