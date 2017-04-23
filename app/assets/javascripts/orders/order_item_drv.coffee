orderItemDirective = ->
  restrict: "E"
  scope: false
  templateUrl: "orders/item.html"

angular.module "app.orders"
  .directive "orderItem", [orderItemDirective]
