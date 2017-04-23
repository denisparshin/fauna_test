directive = ->
  restrics: "A"
  scope: false
  link: (scope, element, attrs) ->
    scope.autoSubmit = ->
      $('.progress-red-value').stop().animate({ width: 0 }, 1).animate { width: '100%' }, 50, ->
        element.find("input[type='submit']").trigger("click")
        $('.progress-red-value').css width: 0
        return
      return

angular.module "app.shared"
  .directive "autosubmitForm", [directive]
