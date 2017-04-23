class Product < ActiveRecord::Base
  belongs_to :category
  belongs_to :metatag, dependent: :destroy
  has_one :slider, as: :sliderable, dependent: :destroy
  has_many :sub_products, dependent: :destroy
  has_many :comments, as: :commentable

  scope :by_catalog_id, -> (catalog_ids) {
    joins(category: :catalog).where("catalogs.id" => catalog_ids) if catalog_ids
  }

  scope :by_category_id, -> (category_ids){
    joins(:category).where("categories.id" => category_ids) if category_ids
  }

  scope :by_keyword, -> (keyword){
    joins(:sub_products).where(search_string(
      ["products.name", "products.description", "sub_products.name", "sub_products.description", "sub_products.sku"], keyword
    )).uniq if keyword
  }

  scope :order_by, -> (params){
    order(params.split('-')[0] => params.split('-')[1]) if params
  }

  scope :index, -> (search) {
    includes(:sub_products, slider: :pictures, category: :catalog)
    .by_catalog_id(search.catalog_id)
    .by_category_id(search.category_id)
    .order_by(search.order_by)
    .by_keyword(search.keyword)
  }

  accepts_nested_attributes_for :metatag

  def self.search_string(fields, keyword)
    search_field_params(keyword, fields.length).unshift(fields.map{|i| "lower(#{i}) LIKE ?"}.join(" OR "))
  end

  def self.search_field_params(keyword, length=1)
    (0...length).map{|i|
      "%#{keyword.mb_chars.downcase.to_s.split(" ").join("%")}%"
    }
  end
end
