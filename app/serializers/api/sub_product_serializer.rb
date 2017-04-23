class Api::SubProductSerializer < ApiSerializer
  attributes :id

  def index
    [:id,
     :sku,
     :name,
     :price,
     :visible,
     :avail,
     :count]
  end

  def as_order
    [:sku,
     :product]
  end

  def in_products
    [:price, :sku, :name]
  end

  def product
    serialize_object object.product, Api::ProductSerializer, {scope: :as_order}
  end
end
