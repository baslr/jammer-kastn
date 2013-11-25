
requirejs.config
  shim:
    'angular-route':
      deps: ['angular']
    'bootstrap':
      deps: ['jquery']
  
  paths:
    'angular'      : '/angular-1-2-2'
    'angular-route': '/angular-route-1-2-2'

    'jquery'       : '/jquery-2-0-3'
    'bootstrap'    : '/js/bootstrap'
      
     

require ['app', 'angular', 'templates', 'bootstrap']
         , () ->
  console.log 'called main.js'

  angular.bootstrap document, ['demoApp']
