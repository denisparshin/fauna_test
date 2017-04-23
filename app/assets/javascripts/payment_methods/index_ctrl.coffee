paymentMethodsIndexCtrl = ($scope, $rootScope, safeApply) ->
  $params = App.Params.get()
  $rootScope.waiting = true
  $scope._chunk = _.chunk
  CRUD.index "payment_methods", {showall: true}, (response) ->
    $scope.payment_methods = response.payment_methods
    $rootScope.waiting = false
    safeApply($scope)

  $scope.submit = (sub, form) ->
    CRUD.create "payment_methods", {payment_method: sub}, (response) ->
          if response.payment_method.id
            sub.id = response.payment_method.id
            App.Alert.show "success", I18n.t("js.payment_methods.info.successfully_created")
          else
            App.Alert.show "danger", I18n.t("js.info.something_went_wrong")
        form.$setPristine()
  

   
  
  
  

                

angular.module "app.payment_methods"
  .controller "paymentMethodsIndexCtrl", [
    "$scope"
    "$rootScope"
    "safeApply"
    paymentMethodsIndexCtrl
]