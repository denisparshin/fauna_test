paymentMethodsShowCtrl = ($scope, $rootScope, safeApply, $routeParams, $location) ->
  $rootScope.waiting = true
  resource = if $routeParams.paymentMethodId then {n: "payment_method", p: "payment_methods", id: $routeParams.paymentMethodId} 
  
  CRUD.show resource.p, resource.id, (response) ->
    $scope.paymentMethod = response[resource.n]
    $rootScope.waiting = false
    safeApply($scope)

  $scope.updatePaymentMethod = ->
    CRUD.update resource.p, resource.id, _.object([[resource.n, _.getByKeys($scope.paymentMethod, ["name", "description"])]]), (response) ->
      App.Alert.show "info", I18n.t("js.payment_methods.is_updated")
      $scope.paymentMethodForm.$setPristine()
      safeApply($scope)

  $scope.removePaymentMethod = (id) ->
    CRUD.remove resource.p, resource.id, (response) ->
      if response.id
        App.Alert.show "info", I18n.t("js.payment_methods.info.successfully_removed")
        
        
      else 
        App.Alert.show "danger", response.error || I18n.t("js.info.something_went_wrong") 

  


angular.module "app.payment_methods"
  .controller "paymentMethodsShowCtrl", [
    "$scope"
    "$rootScope"
    "safeApply"
    "$routeParams"
    paymentMethodsShowCtrl
  ]