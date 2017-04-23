class SubProduct < ActiveRecord::Base
  has_and_belongs_to_many :filter_values
  belongs_to :product

  scope :with_products, -> (product_ids) { where(product_id: product_ids) if product_ids }
  scope :by_ids, -> (ids) { where(id: ids) if ids }
  scope :as_order, -> (search) { includes(product: {slider: :pictures}).by_ids(search.sub_product_ids) }
  scope :index, -> (search) { with_products(search.product_ids).by_ids(search.sub_product_ids) }
end
