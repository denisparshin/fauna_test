angular.module "app.core"
  .config ["$routeProvider", ($routeProvider) ->
    $routeProvider
      .when '/sign_up',
        templateUrl: 'auth/sign_up.html',
        controller: 'registrationCtrl'
      .when '/sign_in',
        templateUrl: 'auth/sign_in.html',
        controller: 'sessionsCtrl'
      .when '/import',
        templateUrl: 'import/show.html',
        controller: 'importCtrl'
      .when '/products',
        templateUrl: 'products/index.html',
        controller: 'productsIndexCtrl'
      .when '/catalogs',
        templateUrl: 'catalogs/index.html',
        controller: 'catalogsIndexCtrl'
      .when '/catalogs/:id',
        templateUrl: 'catalogs/show.html',
        controller: 'catalogsShowCtrl'
      .when '/catalogs/:id/categories/:categoryId',
        templateUrl: 'catalogs/show.html',
        controller: 'catalogsShowCtrl'
      .when '/products/:id',
        templateUrl: 'products/show.html',
        controller: 'productsShowCtrl'
      .when '/products/:id/:activeTab',
        templateUrl: 'products/show.html',
        controller: 'productsShowCtrl'
      .when '/orders',
        templateUrl: 'orders/index.html',
        controller: 'ordersIndexCtrl',
      .when '/top_slider',
        templateUrl: 'top_slider/index.html',
        controller: 'topSliderIndexCtrl',
      .when '/',
        templateUrl: 'orders/index.html',
        controller: 'ordersIndexCtrl'
      .when '/users',
        templateUrl: 'users/index.html',
        controller: 'usersIndexCtrl'
      .when '/users/:userId',
        templateUrl: 'users/show.html',
        controller: 'usersShowCtrl'
      .when '/users/:id/:activeTab',
        templateUrl: 'users/show.html',
        controller: 'usersShowCtrl'
      .otherwise
        redirectTo: '/'
      .when '/payment_methods',
        templateUrl: 'payment_methods/index.html',
        controller: 'paymentMethodsIndexCtrl',
      .when '/payment_methods/:paymentMethodId',
        templateUrl: 'payment_methods/show.html',
        controller: 'paymentMethodsShowCtrl'
      
  ]
