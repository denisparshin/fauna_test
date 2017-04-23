class Api::ProductSerializer < ApiSerializer
  attributes :id, :name

  def index
    [:sub_products, :name, :pictures, :catalog, :category ]
  end

  def show
    [ :title,
      :category_id,
      :description,
      :metatag_id,
      :slug,
      :slider,
      :metatag_attributes,
      :to_edit,
    ]
  end

  def new
    [ :title,
      :category_id,
      :description,
      :metatag_id,
      :slug,
      :slider,
      :metatag_attributes,
      :to_edit,
    ]
  end

  def as_order
    [:name, :pic_micro]
  end

  def pic_micro
    object.slider.pictures.first.file.micro.url if object.slider && object.slider.pictures.first
  end

  def metatag_attributes
    if object.metatag
      serialize_object object.metatag, Api::MetatagSerializer, {scope: :in_product}
    else
      {keywords: nil, description: nil}
    end
  end

  def slider
    serialize_object object.slider, Api::SliderSerializer, {scope: :in_product}
  end

  def category
    serialize_object object.category, Api::CategorySerializer, {scope: :in_products}
  end

  def sub_products
    serialize_objects object.sub_products, Api::SubProductSerializer, {scope: :in_products}
  end

  def pictures
    object.slider.try(:pictures).to_a.map{|p| p.file.big.url }
  end
end
