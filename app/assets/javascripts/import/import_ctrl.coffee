controller = ($scope, $http, $modal) ->
  $scope.result = {}

  CRUD.index "catalogs", {showall: true}, (response) ->
    $scope.catalogs = response.catalogs
    $scope.categoryIds = []
    $scope.$apply() unless $scope.$$phase

  $scope.previewPopup = $modal(
    templateUrl: "import/_import_modal.html"
    container: "body"
    show: false
    scope: $scope
  )

  $scope.toggleIds = (catalog) ->
    if catalog.selectall
      $scope.categoryIds = $scope.categoryIds.concat(_.pluck(catalog.categories, "id"))
    else
      cats = $scope.categoryIds
      _.each(_.pluck(catalog.categories, "id"), (item) ->
        cats = _.without(cats, item)
      )
      $scope.categoryIds = cats

  $scope.import = (key) ->
    $scope.previewPopup.hide()
    $scope.$root.waiting = true
    $http(
      method: 'POST'
      data: _.object([[key, $scope.result[key]]])
      url: "/api/import/#{key}").then ((response) ->
        if response.data.success
          App.Alert.show "success", I18n.t("js.import.success")
          $(".btn-file[data-for='#{$scope.activeKey}'] .addon").trigger("click")
        else
          App.Alert.show "danger", I18n.t("js.info.something_went_wrong")
        $scope.processing = false
        $scope.$root.waiting = false
    ), (response) ->
      App.Alert.show "danger", I18n.t("js.info.something_went_wrong")
      $scope.processing = false
      $scope.$root.waiting = false

  $scope.export = (key) ->
    $scope.$root.waiting = true
    $http(
      method: 'POST'
      data: {category_ids: $scope.categoryIds}
      url: "/api/export/#{key}").then ((response) ->
        $scope.$root.waiting = false
        App.FileSaver.saveBlob(App.XLSX.fromArray(response.data[key], key.replace(/^.{1}/, key.toUpperCase().substring(0, 1))), "#{key}_#{(new Date()).toISOString()}.xlsx")
    ), (response) ->
      App.Alert.show "danger", I18n.t("js.info.something_went_wrong")
      $scope.$root.waiting = false

angular.module "app.import"
  .controller "importCtrl", [
    "$scope"
    "$http"
    "$modal"
    controller
  ]
