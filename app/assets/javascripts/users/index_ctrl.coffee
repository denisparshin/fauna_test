usersIndexCtrl = ($scope, $routeParams, $location, safeApply, $rootScope) ->
  
  $params = App.Params.get()
  $params.page = 1 if !$params.page

  $scope.search = if $params.search then $params.search else {}
  safeApply($scope)
  
  getData = () ->

    $scope.$root.waiting = true
    params = $params
    params.search = $scope.search if $scope.search && !_.isEmpty($scope.search)
    CRUD.index "/users", params, (response) ->
      $scope.users = response.users
      $scope.page = response.page
      $scope.per = response.per
      $scope.count = response.count
      $rootScope.waiting = false
      safeApply($scope)
      return
    return

  $scope.searchOrderings = I18n.t('js.products.sorting')

  $scope.submitSearch = ->
    params = {}
    params.page = $params.page if $params.page
    _.each _.keys($scope.search), (k) -> params["search[#{k}]"] = $scope.search[k] if $scope.search[k]
    $location.search(params)
    safeApply($scope)
    getData()   

  getData()          

angular.module "app.users"
  .controller "usersIndexCtrl", [
    "$scope"
    "$routeParams"
    "$location"
    "safeApply"
    "$rootScope"
    usersIndexCtrl
]