
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

    socketService.forward ['set-notes', 'msg'], scope

    scope.$on 'set-notes', (e, notes) -> scope.notes = notes

    scope.currentYear = new Date().getFullYear()
    scope.currentWeek = weeksService.getCurrentWeek()
    scope.notes       = []

    notesService.getNotesForWeek scope.currentYear, scope.currentWeek

    updateDropdown weeksService.getList scope.currentYear, scope.currentWeek

    scope.prevWeek = () -> updateDropdown weeksService.getList scope.currentYear, scope.currentWeek-1
    scope.nextWeek = () -> updateDropdown weeksService.getList scope.currentYear, scope.currentWeek+1

    scope.selectedWeek = (week) -> updateDropdown weeksService.getList scope.currentYear, week.weekNo

    scope.$on 'msg', (e, msg) -> console.dir msg

  console.log 'defined jammerKastenController'
  return angularModule
