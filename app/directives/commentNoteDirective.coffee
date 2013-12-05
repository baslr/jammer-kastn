
define ['app', 'jquery', 'services/notesService']
, (app, $) ->

  directive = (notesService) ->
    return {

    link: (scope, element, attrs) ->
      console.log 'commentNote'

      keyDown = (e) ->
        code = if e.keyCode? then e.keyCode else e.which
        return if code isnt Number 13

        e.preventDefault()
        console.log 'send comment'

        console.dir scope.note.id

        if element.val().trim() isnt ''
          notesService.addComment scope.note, {comment:element.val().trim(), name:'John Schuman'}
          element.val ''



      element.keydown keyDown
      scope.$on '$destroy', () ->
        element.off 'keyup', keyDown



    }

  console.log 'defined commentNoteDirective'
  app.directive 'commentNote', ['notesService', directive]
  undefined