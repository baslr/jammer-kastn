define ['socketIO']
       , () ->
  class socketService
    constructor: (@rootScope, conf) ->
      console.log 'socketService constructor called'
      console.log conf
      @socket = socket = io.connect "#{conf.protocol}://#{conf.hostname}:#{conf.port}"

      @socket.on 'connect', () ->
        console.log 'socketIO:connect'

    on: (eventName, callback) ->
      @socket.on eventName, () =>
        args = arguments
        @rootScope.$apply =>
          callback.apply @socket, args

    emit: (eventName, data, callback) ->
      console.log 'socketService:emit'
      @socket.emit eventName, data, () =>
        args = arguments
        @rootScope.$apply =>
          callback.apply @socket, args if callback?

  console.log 'defined socketService'
  socketService
