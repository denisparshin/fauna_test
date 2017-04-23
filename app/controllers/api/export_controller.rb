class Api::ExportController < ApplicationController
  def products
    if current_user.has_role? :admin
      render json: {products: [
          [:id, :category_id, :name, :title, :description]
        ].concat(
          Product
            .where(category_id: params[:category_ids])
            .pluck(:id, :category_id, :name, :title, :description)
        )
      }
    end
  end
  def sub_products
    if current_user.has_role? :admin
      render json: {
        sub_products: [
          [:id, :name, :sku, :product_id, :product_name, :category_id, :category_name]
        ].concat(
          SubProduct
            .select("sub_products.id as id,
                     sub_products.name as name,
                     sub_products.sku as sku,
                     sub_products.product_id as product_id,
                     products.name as product_name,
                     products.category_id as category_id,
                     categories.name as category_name")
            .joins("left join products on sub_products.product_id=products.id")
            .joins("left join categories on products.category_id=categories.id")
            .where("products.category_id" => params[:category_ids]).map{|s|
              [s.id, s.name, s.sku, s.product_id, s.product_name, s.category_id, s.category_name]
            }
        )
      }
    end
  end
end
