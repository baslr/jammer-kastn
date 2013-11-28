
define ['jquery']
        , ($) ->

  directive = (notesService) ->
    bMouseDown = false

    return {

    link: (scope, element, attrs) ->
      element.on '$destroy', () -> elem.unbind()

      elem = ($ element[0]).find('DIV:first')
      paps = ($ elem).parent()

      elem.on 'mouseup mouseleave',  () -> bMouseDown = false
      elem.on 'mousedown', (e) ->
        return if e.which isnt 1
        e.preventDefault()

        bMouseDown = true
        z = 1
        ($ 'DIV#notesArea .panel').each ->
          idx = ($ this).css 'z-index'
          z = idx if idx isnt 'auto' and z < idx
        ($ e.target).parent().css 'z-index', ++z

        scope.note.position['z-index'] = z
        notesService.save scope.note

      elem.on 'mousemove', (e) ->
        return if not bMouseDown
        offset= paps.offset()
        pos =
          left : e.originalEvent.webkitMovementX + (if offset.left < 0 then 0 else offset.left) + 'px'
          top  : e.originalEvent.webkitMovementY + (if offset.top  < 0 then 0 else offset.top)  + 'px'
        paps.css pos
        notesService.savePosition scope.note, pos

      console.dir scope
      console.dir element
      console.dir attrs
    }

  console.log 'defined noteMoveDirective'
  return ['notesService', directive]