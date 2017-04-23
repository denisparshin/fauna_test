controller = ($scope, Auth, $location, $rootScope, $route) ->
  $rootScope.ready = false

  $rootScope.allApply = ->
    $rootScope.$apply() if $rootScope.phase != '$apply' && $rootScope.phase != '$digest'
    return true

  redirectToLogin = ->
    $location.path '/sign_in'
    $scope.apply() unless $scope.$$phase
    $route.reload()

  if window.anonimusUser
    $rootScope.ready = true
    $scope.isAuthenticated = false
    $rootScope.user = null
    $scope.currentUser = null
    redirectToLogin()
  else
    Auth.currentUser().then ((response) ->
      $scope.isAuthenticated = true
      $rootScope.ready = true
      $rootScope.user = response.user
      if !response.user.id
        redirectToLogin() unless $location.path() == "/sign_in"
    ), (error) ->
      $rootScope.ready = true
  $scope.$apply() unless $scope.$$phase

  $scope.logout = ->
    Auth.logout().then ((oldUser) ->
      $rootScope.user = undefined
      $location.path '/sign_in'
      $route.reload()
      App.Alert.show "info", I18n.t("js.users.signed_out")
    ), (error) ->

  $scope.$on "$routeChangeSuccess", ->
    $rootScope.currentPath = _.compact($location.path().split("/"))[0]

angular.module "app.core"
  .controller "mainCtrl", [
    "$scope"
    "Auth"
    "$location"
    "$rootScope"
    "$route"
    controller
  ]

