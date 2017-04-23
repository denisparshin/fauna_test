catalogsIndexCtrl = ($scope, $rootScope, safeApply) ->
  $rootScope.waiting = true
  $scope._chunk = _.chunk
  CRUD.index "catalogs", {showall: true}, (response) ->
    $scope.catalogs = response.catalogs
    $rootScope.waiting = false
    safeApply($scope)

    $scope.submit = (sub, form) ->
      CRUD.create "catalogs", {catalog: sub}, (response) ->
        if response.catalog.id
          sub.id = response.catalog.id
          App.Alert.show "success", I18n.t("js.catalogs.info.successfully_created")
        else
          App.Alert.show "danger", I18n.t("js.info.something_went_wrong")
      form.$setPristine()
    
    $scope.createCategory = (cat, form) ->
      CRUD.create "categories", {category: cat}, (response) ->
        if response.category.id
          cat.id = response.category.id
          App.Alert.show "success", I18n.t("js.categories.info.successfully_created")
        else
          App.Alert.show "danger", I18n.t("js.info.something_went_wrong")
      form.$setPristine()

angular.module "app.catalogs"
  .controller "catalogsIndexCtrl", [
    "$scope"
    "$rootScope"
    "safeApply"
    catalogsIndexCtrl
]