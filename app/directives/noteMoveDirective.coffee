
define ['jquery']
        , ($) ->

  directive = (notesService) ->
    return {

    link: (scope, paps, attrs) ->
      elem = ($ paps[0]).find('DIV:first')

      mouseMove = (e) ->
        e.preventDefault()
        offset= paps.offset()
        pos =
          left : e.originalEvent.webkitMovementX + (if offset.left < 0 then 0 else offset.left) + 'px'
          top  : e.originalEvent.webkitMovementY + (if offset.top  < 0 then 0 else offset.top)  + 'px'

        notesService.setPosition scope.note.id, pos
        paps.css pos

      mouseUp = () ->
        ($ document).off 'mousemove', mouseMove
        ($ document).off 'mouseup',   mouseUp

      mouseDown = (e) ->
        return if e.which isnt 1
        e.preventDefault()

        z = 1
        ($ 'DIV#notesArea .panel').each ->
          idx = ($ this).css 'z-index'
          z = idx if idx isnt 'auto' and z < idx
        paps.css 'z-index', ++z

        notesService.setIndex scope.note.id, z

        ($ document).on 'mousemove', mouseMove
        ($ document).on 'mouseup',   mouseUp

      paps.on '$destroy', () ->
        console.log 'paps.on $destroy'
        elem.off 'mousedown', mouseDown
        mouseUp()
        elem = null
        paps = null

      scope.$on '$destroy', () -> console.log 'scope.on $destroy'

      elem.on 'mousedown', mouseDown
      null
    }

  console.log 'defined noteMoveDirective'
  return ['notesService', directive]