
define ['jquery']
        , ($) ->

  directive = (notesService) ->
    return {

    link: (scope, element, attrs) ->
      element.on '$destroy', () -> elem.unbind()

      elem = ($ element[0]).find('DIV:first')
      paps = ($ elem).parent()

      mouseMove = (e) ->
        e.preventDefault()
        offset= paps.offset()
        pos =
          left : e.originalEvent.webkitMovementX + (if offset.left < 0 then 0 else offset.left) + 'px'
          top  : e.originalEvent.webkitMovementY + (if offset.top  < 0 then 0 else offset.top)  + 'px'
        paps.css pos
        notesService.setPosition scope.note.id, pos

      mouseUp = () ->
        ($ document).unbind 'mousemove', mouseMove
        ($ document).unbind 'mouseup',    mouseUp

      elem.on 'mousedown', (e) ->
        return if e.which isnt 1
        e.preventDefault()

        z = 1
        ($ 'DIV#notesArea .panel').each ->
          idx = ($ this).css 'z-index'
          z = idx if idx isnt 'auto' and z < idx
        ($ e.target).parent().css 'z-index', ++z

        scope.note.position['z-index'] = z
        notesService.setIndex scope.note.id, z

        ($ document).on 'mousemove', mouseMove
        ($ document).on 'mouseup',   mouseUp

      console.dir scope
      console.dir element
      console.dir attrs
    }

  console.log 'defined noteMoveDirective'
  return ['notesService', directive]