directive = ->
  restrict: "E"
  scope:
    userId: "="
  templateUrl: "users/_tab_orders.html"
  controller: ["$scope", "safeApply", "$routeParams", ($scope, safeApply, $routeParams) ->
    if !$scope.$root.ready
     CRUD.index "orders", {page: $routeParams.page}, (response) ->
      $scope.$root.ready = true
      _.each response.orders, (ord) ->
        ord.order_data = _.object(_.map(ord.order_data, (i) -> [i.id, i]))
      $scope.orders = response.orders
      $scope.page = response.page
      $scope.per = response.per
      $scope.count = response.count
      safeApply($scope)
  ]

angular.module "app.users"
  .directive "userTabOrders", [directive]
