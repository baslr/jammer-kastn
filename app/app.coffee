
define [  'controllers/jammerKastenController'
        , 'angular'
        , 'angular-route' ]
        , (jammerKasten) ->
  
  demoApp = angular.module 'demoApp', ['ngRoute']
  
  demoApp.config ['$routeProvider', (route) ->
    route.when '/view1',
      controller  : 'jammerKastenController'
      templateUrl : 'view1.html'
    
    route.otherwise redirectTo: '/view1'
  ]
  
  demoApp.run ->
    console.log 'demoApp.run:test'
  
  console.log 'setup called'

  demoApp.controller 'jammerKastenController', jammerKasten
  

  
#  demoApp.service 'testService', testService
  
  return demoApp
