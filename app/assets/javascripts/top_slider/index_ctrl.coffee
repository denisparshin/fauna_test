controller = ($scope, $modal, safeApply) ->
  previewPicModal = $modal
    templateUrl: "products/_preview_pic_modal.html"
    scope: $scope
    show: false
    container: "body"

  carouselModal = $modal
    templateUrl: "top_slider/_carousel_modal.html"
    scope: $scope
    show: false
    container: "body"

  $scope.removePic = (id, index) ->
    CRUD.remove "top_sliders", id, (response) ->
      if response.id
        $scope.topSliders.splice(index, 1)
        safeApply($scope)
        App.Alert.show "info", I18n.t("js.pictures.info.successfully_removed")
      else
        App.Alert.show "danger", I18n.t("js.info.something_went_wrong")

  CRUD.index "top_sliders", {showall: true}, (response) ->
    $scope.topSliders = response.top_sliders
    $scope.$root.waiting = false
    safeApply($scope)

  $scope.showPreview = (input) ->
    $scope.newPicture = input.files[0]
    $scope.newPictureUrl = URL.createObjectURL($scope.newPicture)
    previewPicModal.show()

  $scope.carouselShow = (index) ->
    $scope.activePic = index
    carouselModal.show()

  $scope.uploadNew = () ->
    $scope.loadingPic = true
    previewPicModal.hide()
    fd = new FormData()
    fd.append "top_slider[file]", $scope.newPicture
    $.ajax
      url: '/api/top_sliders'
      data: fd
      processData: false
      contentType: false
      type: 'POST'
      success: (response) ->
        $scope.topSliders.push response.top_slider
        $scope.loadingPic = false
        safeApply($scope)
      error: () ->
        App.Alert.show "danger", I18n.t("js.info.something_went_wrong")

angular.module "app.top_slider"
  .controller "topSliderIndexCtrl", [
    "$scope"
    "$modal"
    "safeApply"
    controller
  ]
