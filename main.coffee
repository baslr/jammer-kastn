
requirejs.config
  shim:
    'angular-route':
      deps: ['angular']
    'bootstrap':
      deps: ['jquery']
  
  paths:
    'angular'      : '/vendor/js/angular-1-2-2'
    'angular-route': '/vendor/js/angular-route-1-2-2'

    'jquery'       : '/vendor/js/jquery-2-0-3'
    'bootstrap'    : '/vendor/js/bootstrap'
      
     

require ['app', 'angular', 'templates', 'bootstrap']
         , () ->
  console.log 'called main.js'

  angular.bootstrap document, ['demoApp']
