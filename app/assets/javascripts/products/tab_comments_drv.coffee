directive = ->
  restrict: "A"
  scope:
    productId: "="
  templateUrl: "products/_tab_comments.html"
  controller: ["$scope", ($scope) ->
  ]

angular.module "app.products"
  .directive "productTabComments", [directive]
