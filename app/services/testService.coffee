define []
        , () ->
  class TestService
    constructor: (@test) ->
      console.log 'constructed testService'

    get: -> @test
  
  console.log 'defined TestService'
  TestService