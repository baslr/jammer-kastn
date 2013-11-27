
define ['jquery']
        , ($) ->
  angularModule = [  '$scope'
                   , 'weeksDisplayService'
                   , 'notesService'
                   , 'socketService' ]

  angularModule.push (scope, weeksService, notesService, socketService) ->
    console.log 'called jammerKastenController'

    updateDropdown = (list) ->
      scope.currentWeek = list.week
      scope.currentYear = list.year
      scope.weeksDropdown = weeksService.generateDropdown list, notesService.getNoteCount list
      scope.notes = []
      notesService.getNotesForWeek scope.currentYear, scope.currentWeek

    socketService.on 'set-notes', (notes) ->
      scope.notes   = notes

    scope.currentYear = new Date().getFullYear()
    scope.currentWeek = weeksService.getCurrentWeek()
    scope.notes       = []

    notesService.getNotesForWeek scope.currentYear, scope.currentWeek

    updateDropdown weeksService.getList scope.currentYear, scope.currentWeek

    scope.prevWeek = () -> updateDropdown weeksService.getList scope.currentYear, scope.currentWeek-1
    scope.nextWeek = () -> updateDropdown weeksService.getList scope.currentYear, scope.currentWeek+1

    bMouseDown = false

    scope.noteMouseUp = scope.noteMouseLeave = () -> bMouseDown = false

    scope.noteMouseDown = ($event, note) ->
      return if $event.which isnt 1

      $event.preventDefault()

      bMouseDown = true
      z = 1
      ($ 'DIV#notesArea .panel').each ->
        idx = ($ this).css 'z-index'
        z = idx if idx isnt 'auto' and z < idx
      ($ $event.target).parent().css 'z-index', ++z

      note.position['z-index'] = z
      notesService.save note
      undefined


    scope.noteMouseMove = ($event, note) ->
      return if not bMouseDown

      $elem = ($ event.target).parent()
      offset= $elem.offset()
      pos =
        left : $event.webkitMovementX + (if offset.left < 0 then 0 else offset.left) + 'px'
        top  : $event.webkitMovementY + (if offset.top  < 0 then 0 else offset.top)  + 'px'

      $elem.css pos
      notesService.savePosition note, pos
      undefined


    scope.selectedWeek = (week) -> updateDropdown weeksService.getList scope.currentYear, week.weekNo

    socketService.on 'msg', (msg) ->
      console.dir msg

  console.log 'defined jammerKastenController'
  return angularModule
