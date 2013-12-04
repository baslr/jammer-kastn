define ['socketIO', 'angular']
       , () ->
  class socketService
    constructor: (@rootScope, @timeout, conf) ->
      console.log 'socketService constructor called'
      console.log conf
      @socket = io.connect "#{conf.protocol}://#{conf.hostname}:#{conf.port}"

      @socket.on 'connect', () ->
        console.log 'socketIO:connect'

    asyncCall: (cb) ->
      return () =>
        args = arguments
        @timeout () =>
          cb.apply @socket, args
          null
        , 0


    on: (eventName, cb) ->
      console.log "socketService:on:#{eventName}"
      @socket.on eventName, @asyncCall cb


    emit: (eventName, data, cb) ->
      dataIn = data
      dataIn = JSON.parse angular.toJson data if typeof data is 'object'
      console.log "socketService:emit:#{eventName}"
      if cb? then @socket.emit eventName, dataIn, @asyncCall cb
      else        @socket.emit eventName, dataIn


    forward: (events, scope) ->
      events = [events]   if   events instanceof Array is false
      scope  = @rootScope if ! scope?

      events.forEach (eventName) =>
        eName = eventName
        forwardEvent = @asyncCall (data) ->
            scope.$broadcast eName, data
        scope.$on '$destroy', () =>
          @socket.removeListener eName, forwardEvent
        @socket.on eName, forwardEvent


  console.log 'defined socketService'

  service = angular.module 'socketServiceModule', []

  service.provider 'socketService', () ->
    conf = {port:4433, hostname:'0.0.0.0', protocol:'https'}
    return {
      $get : [ '$rootScope', '$timeout', (rootScope, timeout) ->
        new socketService rootScope, timeout, conf ]
      set  : (confIn) -> conf = confIn
    }

  undefined