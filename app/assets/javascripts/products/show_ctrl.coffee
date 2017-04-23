controller = ($scope, $routeParams, $location) ->
  $scope.productId = $routeParams.id
  $scope.tabs = ["info", "sub_products", "slider", "comments"]
  $scope.activeTab = if _.contains($scope.tabs, $routeParams.activeTab) then $routeParams.activeTab else $scope.tabs[0]
  $scope.removeProduct = (id) ->
    CRUD.remove "products", id, (response) ->
      if response.id
        App.Alert.show "info", I18n.t("js.products.info.successfully_removed")
        $location.path "/products"
        $scope.$apply() unless $scope.$$phase
      else 
        App.Alert.show "danger", response.error || I18n.t("js.info.something_went_wrong") 


angular.module "app.products"
  .controller "productsShowCtrl", [
    "$scope"
    "$routeParams"
    "$location"
    controller
  ]
