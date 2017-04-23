controller = ($scope, $routeParams, $location) ->
  $scope.userId = $routeParams.id
  $scope.tabs = ["info", "orders"]
  $scope.activeTab = if _.contains($scope.tabs, $routeParams.activeTab) then $routeParams.activeTab else $scope.tabs[0]
  $scope.removeUser = (id) ->
    CRUD.remove "users", id, (response) ->
      if response.id
        App.Alert.show "info", I18n.t("js.products.info.successfully_removed")
        $location.path "/users"
        $scope.$apply() unless $scope.$$phase
      else 
        App.Alert.show "danger", response.error || I18n.t("js.info.something_went_wrong") 


angular.module "app.users"
  .controller "usersShowCtrl", [
    "$scope"
    "$routeParams"
    "$location"
    controller
  ]
