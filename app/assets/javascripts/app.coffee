//= require ./core/core
//= require ./auth/auth
//= require ./products/products
//= require ./catalogs/catalogs
//= require ./shared/shared
//= require ./import/import
//= require ./orders/orders
//= require ./top_slider/top_slider
//= require ./payment_methods/payment_methods
//= require ./users/users


angular.module "app", [
  "ngRoute"
  "templates"
  "Devise"
  "ngSanitize"
  "ngFileUpload"
  "pascalprecht.translate"
  "mgcrea.ngStrap.core"
  "mgcrea.ngStrap.helpers.dimensions"
  "mgcrea.ngStrap.modal"
  "mgcrea.ngStrap.tooltip"
  "mgcrea.ngStrap.helpers.dateParser"
  "mgcrea.ngStrap.helpers.dateFormatter"
  "mgcrea.ngStrap.datepicker"
  "mgcrea.ngStrap.select"
  "summernote"
  "checklist-model"
  "app.core"
  "app.auth"
  "app.products"
  "app.catalogs"
  "app.shared"
  "app.import"
  "app.orders"
  "app.top_slider"
  "app.payment_methods"
  "app.users"



]

I18n.defaultLocale = "ru-ua"
I18n.locale = "ru-ua";
I18n.currentLocale()

angular.module "app"
  .config [ "$translateProvider", ($translateProvider) ->
    $translateProvider.preferredLanguage(I18n.locale);
    $translateProvider.useSanitizeValueStrategy "sanitize"
    $translateProvider.translations I18n.locale, I18n.translations[I18n.locale]
  ]
