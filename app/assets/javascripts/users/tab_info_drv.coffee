directive = ->
  restrict: "A"
  scope:
    userId: "="
  templateUrl: "users/_tab_info.html"
  controller: ["$scope", "$rootScope", "safeApply", "$routeParams", "$location", ($scope, $rootScope, safeApply, $routeParams, $location) ->
    $rootScope.waiting = true
    resource = if $routeParams.userId then {n: "user", p: "users", id: $routeParams.userId}  
    CRUD.show resource.p, resource.id, (response) ->
      $scope.user = response[resource.n]
      $rootScope.waiting = false
      safeApply($scope)

    $scope.updateUser = (data) ->
      user = _.object(_.map(["first_name", "last_name", "username", "email", "phone", "discount", "city", "address",], (k) -> [k, data[k]]))
      CRUD.update "users", $scope.user.id, {user: user}, (response) ->
        App.Alert.show "success", I18n.t("js.users.info.successfully_updated")



    
 
  ]

    

angular.module "app.users"
  .directive "userTabInfo", [directive]
