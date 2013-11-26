
define [  'controllers/jammerKastenController'
        , 'services/weeksDisplayService'
        , 'services/notesService'
        , 'angular'
        , 'angular-route' ]
        , (jammerKasten, weeksDisplayService, notesService) ->
  
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

  demoApp.service 'weeksDisplayService', weeksDisplayService
  demoApp.service 'notesService',        notesService
  
  return demoApp
