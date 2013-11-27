
requirejs.config
  shim:
    'angular-route':
      deps: ['angular']
    'bootstrap':
      deps: ['jquery']

    'jquery':
      deps: ['angular']  # load angular bevor jquery to get not the jquery.event in the ng-mouse events
  
  paths:
    'angular'      : '/vendor/js/angular-1-2-2'
    'angular-route': '/vendor/js/angular-route-1-2-2'

    'jquery'       : '/vendor/js/jquery-2-0-3'
    'bootstrap'    : '/vendor/js/bootstrap'
    'socketIO'     : '/vendor/js/socket.io-0-9-16'
      
     

require ['angular', 'app', 'templates', 'bootstrap']
         , () ->
  console.log 'called main.js'

  angular.bootstrap document, ['demoApp']
