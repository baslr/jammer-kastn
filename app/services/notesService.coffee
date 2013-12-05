
define ['app',
        'services/socketService',
        'services/weeksService']
        , (app) ->
  class notesService
    constructor: (@socket, @weeksService) ->
      console.log 'notesSocket constructor'
      console.dir  @socket

    requestNotesForWeek: (year, week) ->
      @socket.emit 'get-notes', {year:year, week:week}

    requestYearWeek: (scope, year, week) ->
      maxWeek = @weeksService.getMaxWeek()
      if week is 0
        year--
        week = maxWeek
      if maxWeek < week
        year++
        week = 1

      obj  = {year:year, week:week}
      scope.$emit 'set-year-week', obj
      return obj


    requestNotesAndDropDown: (scope, year, week) ->
      obj = @requestYearWeek  scope, year, week

      @requestNotesForWeek obj.year, obj.week

      @socket.emit 'get-dropdown', obj


    setPosition: (noteId, pos = {left:'0px',top:'0px'}) ->
      @socket.emit 'set-position', {id:noteId, pos:pos}

    setIndex: (noteId, index) ->
      @socket.emit 'set-index', {id:noteId, index:index}

    addNote:       (note) -> @socket.emit 'add-note', note
    addComment:    (note, comment) -> @socket.emit 'add-comment', {noteId:note.id, comment:comment}

    setHideStatus: (note) -> @socket.emit 'set-hide-status', {id:note.id,hide:note.hide}


  console.log 'defined notesService'
  app.service 'notesService', ['socketService', 'weeksService', notesService]
  undefined
