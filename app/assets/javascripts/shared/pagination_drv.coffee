paginationDirective = ->
  restrict: "E"
  replace: true
  scope:
    per: "="
    count: "="
    page: "="
  templateUrl: "shared/pagination.html"
  controller: ["$scope", "$location", "$routeParams", "safeApply", ($scope, $location, $routeParams, safeApply) ->
    calculatePages = ->
      buf = []
      o = 0
      start = $scope.page - 3
      while o < 7
        if start >= 1
          buf.push start
          o++
        start++
        break if start >= $scope.pagesAmount
      buf

    updatePager = ->
      $scope.params = _.map(_.without(_.keys($location.search()), "page"), (e) -> "#{e}=#{$location.search()[e]}").join("&")
      $scope.path = $location.path()
      $scope.pagesAmount = Math.ceil $scope.count / $scope.per
      $scope.viewPages = calculatePages()
      if $routeParams.page && parseInt($routeParams.page) > $scope.pagesAmount
        $location.search $.extend(_.omit($location.search(), "page"), {page: $scope.pagesAmount})
      safeApply($scope)


    $scope.page = 1 unless $scope.page
    $scope.$watch "count", -> updatePager()
    $scope.$watch "page", -> updatePager()


  ]
angular.module "app.shared"
  .directive "pagination", [paginationDirective]
