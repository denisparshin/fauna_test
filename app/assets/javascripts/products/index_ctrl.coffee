controller = ($scope, $routeParams, $location, safeApply, $rootScope) ->

  loaded = false

  $scope.catalogs = false
  $params = App.Params.get()
  $params.page = 1 if !$params.page

  $scope.search = if $params.search then $params.search else {}
  safeApply($scope)

  $scope.submit = (sub, form) ->
    CRUD.create "products", {product: sub}, (response) ->
      if response.product.id
        sub.id = response.product.id
        App.Alert.show "success", I18n.t("js.products.info.successfully_created")
      else
        App.Alert.show "danger", I18n.t("js.info.something_went_wrong")
    form.$setPristine()

  getData = () ->

    $rootScope.waiting = true
    params = $params
    params.search = $scope.search if $scope.search && !_.isEmpty($scope.search)
    CRUD.index "products", params, (response) ->
      $scope.products = response.products
      $scope.page = response.page
      $scope.per = response.per
      $scope.count = response.count
      if $scope.catalogs
        $rootScope.waiting = false
      if !$scope.catalogs
        CRUD.index "catalogs", {showall: true}, (response) ->
          $rootScope.waiting = false
          $scope.catalogs = response.catalogs
          $scope.categories = _.flatten _.map(response.catalogs, (c) ->
            _.map c.categories, (c1) ->
              $.extend { catalog_id: c.id }, c1
          )
          safeApply($scope)
          return
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

  $scope.getCategories = ->
    _.compact(_.map $scope.categories, (c) ->
      if !$scope.search.catalog_id || ($scope.search.catalog_id * 1) == c.catalog_id then c else null)


  getData()

  

angular.module "app.products"
  .controller "productsIndexCtrl", [
    "$scope"
    "$routeParams"
    "$location"
    "safeApply"
    "$rootScope"
    controller
]
