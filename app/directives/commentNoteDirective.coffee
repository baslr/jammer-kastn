
define ['app', 'jquery']
, (app, $) ->

  directive = (notesService, user) ->
    return {

    link: (scope, element, attrs) ->
      console.log 'commentNote'
      ul = element.prev()
      
      updateScroll = () -> ul.scrollTop ul[0].scrollHeight
      
      keyDown = (e) ->
        code  =  e.keyCode || e.wich
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
        undefined
      undefined
    }

  console.log 'defined commentNoteDirective'
  app.directive 'commentNote', ['notesService', 'userConfig', directive]
  undefined