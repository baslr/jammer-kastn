
define [  'controllers/jammerKastenController'
        , 'services/weeksService'
        , 'services/notesService'
        , 'services/socketService'
        , 'directives/noteMoveDirective'
        , 'filters/wikipediaUrlFilter'
        , 'angular'
        , 'angular-route'
        , 'angular-sanitize']
        , (jammerKasten, weeksService, notesService, socketService, noteMoveDirective, wikipediaUrlFilter) ->
  
  demoApp = angular.module 'demoApp', ['ngRoute', 'ngSanitize']

  demoApp.provider 'socketService', () ->
    conf = {port:4433, hostname:'0.0.0.0', protocol:'https'}
    return {
      $get : [ '$rootScope', '$timeout', (rootScope, timeout) ->
        new socketService rootScope, timeout, conf ]
      set  : (confIn) -> conf = confIn
    }
  
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


  demoApp.controller 'jammerKastenController', jammerKasten

  demoApp.service 'weeksService', weeksService
  demoApp.service 'notesService', notesService

  demoApp.directive 'noteMove',     noteMoveDirective
  demoApp.filter    'wikipediaUrl', wikipediaUrlFilter

  console.log 'defined app'
  return demoApp
