
define [  'controllers/jammerKastenController'
        , 'services/weeksDisplayService'
        , 'services/notesService'
        , 'services/socketService'
        , 'angular'
        , 'angular-route' ]
        , (jammerKasten, weeksDisplayService, notesService, socketService) ->
  
  demoApp = angular.module 'demoApp', ['ngRoute']

  demoApp.provider 'socketService', () ->
    conf = {port:4433, hostname:'0.0.0.0', protocol:'https'}
    return {
      $get : [ '$rootScope', (rootScope) -> new socketService rootScope, conf ]
      set  : (confIn) -> conf = confIn
    }
  
  demoApp.config ['$routeProvider', '$locationProvider', 'socketServiceProvider', (route, locationProvider, socketServiceProvider) ->
    locationProvider.html5Mode true
    route.when '/view1',
      controller  : 'jammerKastenController'
      templateUrl : 'view1.html'
    
    route.otherwise redirectTo: '/view1'

    socketServiceProvider.set {port:3344, hostname:'127.0.0.1', protocol:'http'}
  ]
  
  demoApp.run ->
    console.log 'demoApp.run:test'
  
  console.log 'setup called'

  demoApp.controller 'jammerKastenController', jammerKasten

  demoApp.service 'weeksDisplayService', weeksDisplayService
  demoApp.service 'notesService',        ['socketService', notesService]
  
  return demoApp
