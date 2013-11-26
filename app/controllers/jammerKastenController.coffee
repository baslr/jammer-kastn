
define ['jquery']
        , ($) ->

  controller = (scope, weeksService, notesService) ->
    console.log 'called jammerKastenController'

    updateDropdown = (list) ->
      scope.currentWeek = list.week
      scope.currentYear = list.year
      notes = notesService.getNoteCount list
      scope.weeksDropdown = weeksService.generateDropdown list, notes
      scope.notes = notesService.getNotesForWeek scope.currentYear, scope.currentWeek

    scope.currentYear = new Date().getFullYear()
    scope.currentWeek = weeksService.getCurrentWeek()
    scope.notes       = notesService.getNotesForWeek scope.currentYear, scope.currentWeek

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
        left  : $event.webkitMovementX + (if offset.left < 0 then 0 else offset.left) + 'px'
        top   : $event.webkitMovementY + (if offset.top  < 0 then 0 else offset.top)  + 'px'

      $elem.css pos
      note.position.top  = pos.top
      note.position.left = pos.left
      notesService.save note
      undefined


    scope.selectedWeek = (week) -> updateDropdown weeksService.getList scope.currentYear, week.weekNo


  console.log 'defined jammerKastenController'
  return ['$scope', 'weeksDisplayService', 'notesService', controller]
