
define [  'angular'
        , 'angular-route'
        , 'angular-sanitize']
        , () ->
  
  demoApp = angular.module 'demoApp', ['ngRoute', 'ngSanitize', 'socketServiceModule']

  demoApp.config ['$routeProvider', '$locationProvider', 'socketServiceProvider', (route, locationProvider, socketServiceProvider) ->
    locationProvider.html5Mode true
    route.when '/',
      controller  : 'jammerKastenController'
      templateUrl : 'view1.html'
    
    route.otherwise redirectTo: '/'

    socketServiceProvider.set {port:3344, hostname:document.location.hostname, protocol:'http'}
  ]
  
  demoApp.run -> ['$rootScope', 'templateCache', (rootScope, templateCache) ->
      console.log 'demoApp.run:test'
      rootScope.$on '$viewContentLoaded', () ->
        console.log '.on $viewContentLoaded'
        templateCache.removeAll()
  ]
  
  console.log 'defined app'
  
  demoApp.value 'userConfig', {name:'Default', color:'#ffffff'}
  return demoApp
