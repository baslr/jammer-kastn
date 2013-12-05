
define [  'services/socketService'
        , 'angular'
        , 'angular-route'
        , 'angular-sanitize']
        , (socketService, wikipediaUrlFilter) ->
  
  demoApp = angular.module 'demoApp', ['ngRoute', 'ngSanitize', 'socketServiceModule']

  demoApp.config ['$routeProvider', '$locationProvider', 'socketServiceProvider', (route, locationProvider, socketServiceProvider) ->
    locationProvider.html5Mode true
    route.when '/',
      controller  : 'jammerKastenController'
      templateUrl : 'view1.html'
    
    route.otherwise redirectTo: '/'

    socketServiceProvider.set {port:3344, hostname:'127.0.0.1', protocol:'http'}
  ]
  
  demoApp.run -> ['$rootScope', 'templateCache', (rootScope, templateCache) ->
      console.log 'demoApp.run:test'
      rootScope.$on '$viewContentLoaded', () ->
        console.log '.on $viewContentLoaded'
        templateCache.removeAll()
  ]

  console.log 'defined app'
  return demoApp
