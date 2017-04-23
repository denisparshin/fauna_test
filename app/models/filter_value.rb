class FilterValue < ActiveRecord::Base
  has_and_belongs_to_many :sub_products
  belongs_to :filter_group
end
