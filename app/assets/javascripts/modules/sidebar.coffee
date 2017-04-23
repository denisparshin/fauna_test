@module "App.Sidebar", ->
  @toggle = ->
    App.Cookies.createCookie "sidebar_close", 1, if $("body").toggleClass("sidebar-close").hasClass("sidebar-close") then 32 else -32
