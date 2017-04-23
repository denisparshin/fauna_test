controller = ($scope, safeApply, $location) ->

  $params = App.Params.get()
  $params.page = 1 if !$params.page
  $scope.search = $params.search if $params.search
  $scope.statuses = I18n.t("js.orders.statuses")

  $scope.updateStatus = (order, status) ->
    CRUD.update "orders", order.id, order: {status: status}, (response) ->
      order.status = response.order.status
      safeApply($scope)

  search = ->
    $scope.$root.waiting = true
    params = $params
    params.search = $scope.search if $scope.search && !_.isEmpty($scope.search)

    CRUD.index "orders", params, (response) ->
      $scope.orders = response.orders
      $scope.page = response.page
      $scope.per = response.per
      $scope.count = response.count
      subIds = _.uniq(_.flatten(_.map(_.pluck(response.orders, 'data'), (i) ->
        _.map i, (c) ->
          c.id
      )))
      CRUD.index "sub_products", {scope: "as_order", showall: true, search: {sub_product_ids: subIds}}, (response) ->
        $scope.subProducts = $scope.subProducts = _.object(_.map(response.sub_products, (i) -> [i.sku, i]))
        $scope.$root.waiting = false
        safeApply($scope)

  $scope.submitSearch = ->
    params = {}
    params.page = $params.page if $params.page
    _.each _.keys($scope.search), (k) -> params["search[#{k}]"] = $scope.search[k] if $scope.search[k]
    $location.search(params)
    safeApply($scope)
    getData()

  search()


angular.module "app.orders"
  .controller "ordersIndexCtrl", [
    "$scope"
    "safeApply"
    "$location"
    controller
  ]
