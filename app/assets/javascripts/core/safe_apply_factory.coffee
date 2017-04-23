angular.module("app.core").factory 'safeApply', [ ($rootScope) ->
  ($scope, fn) ->
    phase = $scope.$root.$$phase
    if phase == '$apply' or phase == '$digest'
      if fn
        $scope.$eval fn
    else
      if fn
        $scope.$apply fn
      else
        $scope.$apply()
    return
 ]
