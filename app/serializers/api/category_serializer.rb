class Api::CategorySerializer < ApiSerializer
  attributes :id, :name, :slug

  def in_products
    [:catalog]
  end

  def catalog
    serialize_object(object.catalog, Api::CatalogSerializer, {scope: :in_category})
  end

  def show
    [:description, :catalog]
  end

end
