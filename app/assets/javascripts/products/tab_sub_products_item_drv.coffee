directive = ->
  restrict: "E"
  templateUrl: "products/_tab_sub_products_item.html"

angular.module "app.products"
  .directive "tabSubProductsItem", [directive]
