
requirejs.config
  shim:
    'angular-route':
      deps: ['angular']
    'angular-sanitize':
      deps: ['angular']
    'bootstrap':
      deps: ['jquery']

    'angular':
      deps: ['jquery']  # ! load angular bevor jquery to get not the jquery.event in the ng-mouse events
  
  paths:
    'angular'      : '/vendor/js/angular-1-2-3'
    'angular-route'    : '/vendor/js/angular-route-1-2-3'
    'angular-sanitize' : '/vendor/js/angular-sanitize-1-2-3'

    'jquery'       : '/vendor/js/jquery-2-0-3'
    'bootstrap'    : '/vendor/js/bootstrap-3-0-2'
    'socketIO'     : '/vendor/js/socket.io-0-9-16'
      
     

require ['angular', 'app', 'templates', 'bootstrap']
         , () ->
  console.log 'called main.js'

  angular.bootstrap document, ['demoApp']
