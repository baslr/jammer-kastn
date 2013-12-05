
define ['app', 'jquery']
, (app, $) ->

  directive = (notesService, user) ->
    return {

    link: (scope, element, attrs) ->
      console.log 'commentNote'
      ul = element.prev()
      
      updateScroll = () -> ul.scrollTop ul.find('LI:last').offset().top
        
      
      keyDown = (e) ->
        code = if e.keyCode? then e.keyCode else e.which
        return if code isnt Number 13

        e.preventDefault()
        console.log 'send comment'

        console.dir scope.note.id

        if element.val().trim() isnt ''
          notesService.addComment scope.note, {comment:element.val().trim(), name:user.name, style:{'background-color':user.color}}
          element.val ''

      textIn  = () -> ul.bind   'DOMNodeInserted', updateScroll
      textOut = () -> ul.unbind 'DOMNodeInserted', updateScroll
      

      element.keydown keyDown
      element.on 'focusin',  textIn
      element.on 'focusout', textOut
      
      scope.$on '$destroy', () ->
        element.off 'keyup', keyDown
        element.off 'focusin', textIn
        element.off 'focusout', textOut
        
        ul.unbind 'DOMNodeInserted', updateScroll

    }

  console.log 'defined commentNoteDirective'
  app.directive 'commentNote', ['notesService', 'userConfig', directive]
  undefined