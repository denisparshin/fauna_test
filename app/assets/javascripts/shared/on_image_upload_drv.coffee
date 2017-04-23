directive = ->
  restrict: "A"
  scope: false
  controller: ["$scope", ($scope) ->
    $scope.editor = {}
    $scope.imageUpload = (files) ->
      fd = new FormData()
      fd.append "picture[file]", files[0]
      fd.append "picture[imageable_id]", 1
      fd.append "picture[imageable_type]", 'Summernote'
      $.ajax
        url: '/api/pictures'
        data: fd
        processData: false
        contentType: false
        type: 'POST'
        success: (response) ->
          $scope.editor.summernote('editor.insertImage', response.picture.url)
          return
        error: () ->
          App.Alert.show "danger", I18n.t("js.info.something_went_wrong")
          return
    return

  ]
angular.module "app.shared"
  .directive "onImageUpload", [directive]
