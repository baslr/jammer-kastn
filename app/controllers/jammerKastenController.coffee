
global = this


define ['jquery', 'safari-reader']
        , ($, safariReader) ->
  angularModule = [  '$scope'
                   , '$compile'
                   , '$templateCache'
                   , '$q'
                   , '$filter'
                   , 'weeksService'
                   , 'notesService'
                   , 'socketService' ]

  angularModule.push (scope, compile, templateCache, q, filter, weeksService, notesService, socketService) ->
    console.log 'called jammerKastenController'

    socketService.forward ['reset-notes', 'add-note', 'set-dropdown', 'msg'], scope

    scope.$on 'reset-notes',   ()         -> scope.notes = []
    scope.$on 'add-note',      (e, note)  -> scope.notes.push note
    scope.$on 'set-dropdown',  (e, list)  -> scope.weeksDropdown = list
    scope.$on 'set-year-week', (e, data)  ->
        scope.currentWeek = data.week
        scope.currentYear = data.year


    scope.currentYear = new Date().getFullYear()
    scope.currentWeek = weeksService.getCurrentWeek()
    scope.notes       = []

    notesService.requestNotesAndDropDown scope, scope.currentYear, scope.currentWeek

    scope.prevWeek = () ->  notesService.requestNotesAndDropDown scope, scope.currentYear, scope.currentWeek-1
    scope.nextWeek = () ->  notesService.requestNotesAndDropDown scope, scope.currentYear, scope.currentWeek+1

    scope.selectedWeek = (week) -> notesService.requestNotesAndDropDown scope, scope.currentYear, week.weekNo

    scope.$on 'msg', (e, msg) -> console.dir msg

    modal = (opts) ->
      defaultOpts = {focus:'INPUT:first'}
      opts = angular.extend {}, defaultOpts, opts
      html = ($ templateCache.get opts.template)
      deferred  = q.defer()
      noteScope = scope.$new true

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

    scope.openCreateNote = () ->
      modalOk = (html) ->
        text = html.find('TEXTAREA').val()
        cap  = html.find('INPUT').val()
        html.val ''
        return {text:text, caption:cap}

      modal({ok:modalOk, template:'modalCreateNote'}).then (obj) ->
        notesService.addNote {note:obj, week:scope.currentWeek, year:scope.currentYear}

    scope.showHideNote = (note) ->
      if ! note.hide? then note.hide = true
      else                 note.hide = ! note.hide

      notesService.setHideStatus note

    scope.testReader = () ->
      $.get './head.html', (head) ->
        $.get './test.html', (body) ->

          ($ 'HTML HEAD').empty().append  ($ head)
          ($ 'HTML BODY').empty().append  ($ body)

          reader = global.ReaderArticleFinderJS = new safariReader document # site[0]

          console.dir reader.isReaderModeAvailable()

          reader.prepareToTransitionToReader()

          console.log 'reader.article:'
          console.dir reader.article

          adopArticle = reader.adoptableArticle()

          divN = document.createElement("div")
          divN.className="page"

          divR = document.createElement("div")
          divR.className = "page-number"
          divN.appendChild( divR)

          h1 = document.createElement("h1")
          h1.className   = "title"
          h1.textContent = reader.articleTitle()
          divN.appendChild(h1)

          while(adopArticle.firstChild)
            divN.appendChild(adopArticle.firstChild)

          ($ 'BODY').empty().append ($ '<DIV id="article"></DIV>')

          ($ 'BODY').find('DIV#article').append divN



          # ($ 'HTML BODY').empty().append reader.adoptableArticle()


          fileref = document.createElement("link")
          fileref.setAttribute("rel", "stylesheet")
          fileref.setAttribute("type", "text/css")
          fileref.setAttribute "href", '/css/bla.css'

          document.getElementsByTagName("head")[0].appendChild(fileref)

          return

          if !reader.contentDocument.location?
            reader.contentDocument.location = {hostname:'de.wikipedia.org'}
          else
            reader.contentDocument.location.hostname = 'de.wikipedia.org'

          reader.contentDocument.getElementsByTagName = (tag) ->
            console.log "find: #{tag}"
            return [] if tag.toLowerCase() is 'script'
            a = site.find tag
            console.dir a
            b = []
            b.push n for n in a


            console.dir b
            return b
            return site.find tag
            # return site.getElementByTagName tag

          reader.findArticle()

          console.dir reader.articleNode true

          console.dir reader
          console.dir reader.contentDocument

          console.dir reader.isReaderModeAvailable()

          console.dir reader.prepareToTransitionToReader()
          console.dir reader.isMediaWikiPage()

          iframe = document.createElement 'IFRAME'

          ($ iframe).append reader.contentDocument

          # ($ 'HTML').replaceWith reader.contentDocument



    undefined

  console.log 'defined jammerKastenController'
  return angularModule
