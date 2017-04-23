orderSubProductDirective = ->
  restrict: "E"
  scope: false
  templateUrl: "orders/sub_product.html"

angular.module "app.orders"
  .directive "orderSubProduct", [orderSubProductDirective]
