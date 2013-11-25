
define []
        , () ->
  controller = (scope) ->
    console.log 'called simple controller'

    scope.customers= [  {name:'foo', city:'bar'}
                      , {name:'bar', city:'foo'} ]

    scope.add = () ->
      scope.customers.push {name:scope.name, city:'City'}
      scope.name = ''

  console.log 'defined simpleController'
  return ['$scope', controller]
