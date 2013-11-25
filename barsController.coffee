
define []
        , () ->
  controller = (scope, testService, ts2) ->
    console.log 'called bars controller'
    
    console.dir 'testService is:'
    console.dir testService
    scope.bars = testService.get()
    testService.foo()
    
    console.log 'ts2 output for foo'
    ts2.foo()
  
  
  console.log 'defined barsController'
  return ['$scope', 'testService', 'testService2', controller]
