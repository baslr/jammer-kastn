
define [  'simpleController'
        , 'barsController'
        , 'testService'
        , 'jammerKastenController'
        , 'angular'
        , 'angular-route' ]
        , (simpleController, barsController, testService, jammerKasten) ->
    
  demoServices = angular.module 'demoServices', []
  demoServices.factory 'testService',  () -> return new testService() 
  demoServices.factory 'testService2', () -> return new testService()

  
  
  demoApp = angular.module 'demoApp', ['ngRoute', 'demoServices']
  
  demoApp.config ['$routeProvider', (route) ->
    console.log('conf route')
    console.dir(route)
    
    route.when '/view1',
      controller  : 'jammerKastenController'
      templateUrl : 'view1.html'
    
    route.when '/view2',
      controller  :  'barsController'
      templateUrl : 'view2.html'
    
    route.otherwise redirectTo: '/view1'
  ]
  
  demoApp.run ->
    console.log 'demoApp.run:test'
  
  console.log 'setup called'
  
  demoApp.controller 'simpleController', simpleController
  demoApp.controller 'barsController',   barsController
  demoApp.controller 'jammerKastenController', jammerKasten
  

  
#  demoApp.service 'testService', testService
  
  return demoApp
