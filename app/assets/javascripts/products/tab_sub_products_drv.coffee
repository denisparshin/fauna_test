directive = ->
  restrict: "A"
  scope:
    productId: "="
  templateUrl: "products/_tab_sub_products.html"
  controller: ["$scope", ($scope) ->
    $scope.submit = (sub, form) ->
      if sub.id
        CRUD.update "sub_products", sub.id, {sub_product: sub}, (response) ->
          if response.sub_product.id
            App.Alert.show "info", I18n.t("js.sub_products.info.successfully_updated")
          else
            App.Alert.show "danger", I18n.t("js.info.something_went_wrong")
        form.$setPristine()
      else
        CRUD.create "sub_products", {sub_product: sub}, (response) ->
          if response.sub_product.id
            sub.id = response.sub_product.id
            App.Alert.show "success", I18n.t("js.sub_products.info.successfully_created")
          else
            App.Alert.show "danger", I18n.t("js.info.something_went_wrong")
        form.$setPristine()

    $scope.addNew = ->
      $scope.sub_products.push
        id: null
        avail: true
        count: 1
        name: ""
        sku: null
        price: null
        visible: true
        product_id: $scope.productId

    $scope.removeSubProduct = (id, index) ->
      if id
        CRUD.remove "sub_products", id, (response) ->
          if response.id
            $scope.sub_products.splice(index, 1)
            $scope.$apply() unless $scope.$$phase
            App.Alert.show "info", I18n.t("js.sub_products.info.successfully_removed")
          else
            App.Alert.show "danger", I18n.t("js.info.something_went_wrong")
      else
        $scope.sub_products.splice(index, 1)

    CRUD.index "sub_products", {showall: true, search: {product_ids: [$scope.productId]}}, (response) ->
      $scope.sub_products = response.sub_products
      $scope.$apply() unless $scope.$$phase
  ]

angular.module "app.products"
  .directive "productTabSubProducts", [directive]
