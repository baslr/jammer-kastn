
define ['jquery']
        , ($) ->
  angularModule = [  '$scope'
                   , 'weeksService'
                   , 'notesService'
                   , 'socketService' ]

  angularModule.push (scope, weeksService, notesService, socketService) ->
    console.log 'called jammerKastenController'

    socketService.forward ['set-notes', 'set-note-list', 'set-dropdown', 'msg'], scope


    scope.$on 'set-notes',     (e, notes) -> scope.notes         = notes
    scope.$on 'set-dropdown',  (e, list)  -> scope.weeksDropdown = list
    scope.$on 'set-year-week', (e, data)  ->
        scope.currentWeek = data.week
        scope.currentYear = data.year


    scope.currentYear = new Date().getFullYear()
    scope.currentWeek = weeksService.getCurrentWeek()
    scope.notes       = []

    notesService.requestNotesAndDropDown scope, scope.currentYear, scope.currentWeek

    scope.prevWeek = () ->
      scope.notes = []
      notesService.requestNotesAndDropDown scope, scope.currentYear, scope.currentWeek-1
    scope.nextWeek = () ->
      scope.notes = []
      notesService.requestNotesAndDropDown scope, scope.currentYear, scope.currentWeek+1

    scope.selectedWeek = (week) ->
      scope.notes = []
      notesService.requestNotesAndDropDown scope, scope.currentYear, week.weekNo

    scope.$on 'msg', (e, msg) -> console.dir msg
    undefined

  console.log 'defined jammerKastenController'
  return angularModule
