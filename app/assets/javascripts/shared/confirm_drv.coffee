directive = ->
  restrict: "A"
  priority: 1
  scope:
    ngClick: '&'
    confirm: '@',
  controller: ["$scope", "$modal", ($scope, $modal) ->
    $scope.dataConfirmModal = $modal(
      templateUrl: "shared/confirm_modal.html"
      container: "body"
      show: false
      scope: $scope
    )
    $scope.confirmClick = ->
      $scope.dataConfirmModal.hide()
      $scope.ngClick()
  ]
  link: (scope, element, attrs) ->
    element.unbind("click").bind("click", ($event) ->
      $event.preventDefault()
      scope.dataConfirmModal.show()
    )

angular.module "app.shared"
  .directive "confirm", [directive]

