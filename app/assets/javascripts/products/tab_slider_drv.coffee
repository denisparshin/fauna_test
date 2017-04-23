directive = ->
  restrict: "A"
  scope:
    productId: "="
  templateUrl: "products/_tab_slider.html"
  controller: ["$scope", "$modal", ($scope, $modal) ->

    previewPicModal = $modal
      templateUrl: "products/_preview_pic_modal.html"
      scope: $scope
      show: false
      container: "body"

    carouselModal = $modal
      templateUrl: "products/_carousel_modal.html"
      scope: $scope
      show: false
      container: "body"

    $scope.removePic = (id, index) ->
      CRUD.remove "pictures", id, (response) ->
        if response.id
          $scope.slider.pictures.splice(index, 1)
          $scope.$apply() unless $scope.$$phase
          App.Alert.show "info", I18n.t("js.pictures.info.successfully_removed")
        else
          App.Alert.show "danger", I18n.t("js.info.something_went_wrong")

    $scope.updateMainPic = ->
      CRUD.update "sliders", $scope.slider.id, {slider: {primary_pic_id: $scope.slider.primary_pic_id}}, (response) ->
        if response.slider.id
          App.Alert.show "success", I18n.t("js.pictures.info.main_pic_is_set")
        else
          App.Alert.show "danger", I18n.t("js.info.something_went_wrong")

    $scope.carouselShow = (index) ->
      $scope.activePic = index
      carouselModal.show()

    CRUD.index "sliders", {search: {sliderable_type: "Product", sliderable_id: $scope.productId}, showall: true}, (response) ->
      if response.sliders.length
        $scope.slider = response.sliders[0]
        $scope.$apply() unless $scope.$$phase

    $scope.showPreview = (input) ->
      $scope.newPicture = input.files[0]
      $scope.newPictureUrl = URL.createObjectURL($scope.newPicture)
      previewPicModal.show()

    $scope.uploadNew = () ->
      $scope.loadingPic = true
      previewPicModal.hide()
      fd = new FormData()
      fd.append "picture[file]", $scope.newPicture 
      fd.append "picture[imageable_type]", "Slider"
      fd.append "picture[imageable_id]", $scope.slider.id
      $.ajax
        url: '/api/pictures'
        data: fd
        processData: false
        contentType: false
        type: 'POST'
        success: (response) ->
          $scope.slider.pictures.push response.picture
          $scope.loadingPic = false
          $scope.$apply() unless $scope.$$phase
        error: () -> 
          App.Alert.show "danger", I18n.t("js.info.something_went_wrong")

  ]

angular.module "app.products"
  .directive "productTabSlider", [directive]

