directive = ->
  restrict: "A"
  scope:
    productId: "="
  templateUrl: "products/_tab_info.html"
  controller: ["$scope", ($scope) ->

    CRUD.show "products", $scope.productId, (response) ->
      $scope.product = response.product
      $scope.$apply() unless $scope.$$phase

    



    $scope.updateProduct = (data) ->
      product = _.object(_.map(["name", "title", "description", "category_id", "metatag_attributes"], (k) -> [k, data[k]]))
      CRUD.update "products", $scope.product.id, {product: product}, (response) ->
        App.Alert.show "success", I18n.t("js.products.info.successfully_updated")
 
  ]

    

angular.module "app.products"
.directive "productTabInfo", [directive]
