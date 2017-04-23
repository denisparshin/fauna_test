directive = ->
  restrict: "E"
  scope: false
  templateUrl: "products/_products_index_filters.html"
  controller: ["$scope", ($scope) ->
    CRUD.index "filter_groups", {showall: true}, (response) ->
      $scope.filter_groups = response.filter_groups
      $scope.$apply() unless $scope.$$phase
  ]
angular.module "app.products"
.directive "productsIndexFilters", [directive]