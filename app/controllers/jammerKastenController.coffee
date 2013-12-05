
global = this


define ['app', 'jquery', 'safari-reader']
        , (app, $, safariReader) ->
  angularModule = [  '$scope'
                   , '$compile'
                   , '$templateCache'
                   , '$q'
                   , '$filter'
                   , 'weeksService'
                   , 'notesService'
                   , 'socketService']

  angularModule.push (scope, compile, templateCache, q, filter, weeksService, notesService, socketService) ->
    console.log 'called jammerKastenController'

    socketService.forward ['reset-notes', 'add-note', 'add-comment', 'set-dropdown', 'msg'], scope

    scope.$on 'reset-notes',   ()         -> scope.notes = []
    scope.$on 'add-note',      (e, note)  -> scope.notes.push note
    scope.$on 'set-dropdown',  (e, list)  -> scope.weeksDropdown = list
    scope.$on 'set-year-week', (e, data)  ->
        scope.currentWeek = data.week
        scope.currentYear = data.year

    scope.$on 'add-comment', (e, comment) ->
      for note in scope.notes
        if note.id is comment.noteId
          note.comments.push comment.comment


    scope.currentYear = new Date().getFullYear()
    scope.currentWeek = weeksService.getCurrentWeek()
    scope.notes       = []

    notesService.requestNotesAndDropDown scope, scope.currentYear, scope.currentWeek

    scope.prevWeek = () ->  notesService.requestNotesAndDropDown scope, scope.currentYear, scope.currentWeek-1
    scope.nextWeek = () ->  notesService.requestNotesAndDropDown scope, scope.currentYear, scope.currentWeek+1

    scope.selectedWeek = (week) -> notesService.requestNotesAndDropDown scope, scope.currentYear, week.weekNo

    scope.$on 'msg', (e, msg) -> console.dir msg

    modal = (opts) ->
      defaultOpts = {focus:'INPUT:first', okLabel:'OK'}
      opts = angular.extend {}, defaultOpts, opts
      html = ($ templateCache.get 'modalDialog')

      html.find('DIV.modal-body').append ($ templateCache.get opts.template)
      deferred  = q.defer()
      noteScope = scope.$new true
      noteScope.okLabel = opts.okLabel
      closeModal = () ->
        html.modal 'hide'
        undefined

      noteScope.ok = () ->
        deferred.resolve opts.ok html
        closeModal()
      noteScope.cancel = () ->
        deferred.reject false
        closeModal()

      compile(html)(noteScope)
      ($ 'BDOY').append html

      html.on 'shown.bs.modal',  () -> ($ html).find(opts.focus).focus()
      html.on 'hidden.bs.modal', () ->
        html.off()
        noteScope.$destroy()
        html.remove()

      html.modal {keyboard:false}

      return deferred.promise

    scope.openCreateUser = () ->
      modalOk = () ->
        console.log 'ok create user'
        return ''

      modal({ok:modalOk, okLabel:'Hinzufügen', template:'modalCreateUser'}).then(obj) ->
          console.dir obj


    scope.openCreateNote = () ->
      modalOk = (html) ->
        text = html.find('TEXTAREA').val().trim()
        cap  = html.find('INPUT').val().trim()
        html.val ''
        return {text:text, caption:cap}

      modal({ok:modalOk, okLabel:'Erstellen', template:'modalCreateNote'}).then (obj) ->
        notesService.addNote {note:obj, week:scope.currentWeek, year:scope.currentYear}


    scope.showHideNote = (note) ->
      if ! note.hide? then note.hide = true
      else                 note.hide = ! note.hide

      notesService.setHideStatus note

    undefined

  console.log 'defined jammerKastenController'
  app.controller 'jammerKastenController', angularModule
  undefined
