
define ['jquery']
        , ($) ->


  data = [
    {  writer:'Peter Paul'
     , date:'vor zwei Tagen'
     , text: 'ed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.'
     , comments:[  {name:'Hans Müller', comment:'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy' }
                 , {name:'Wolfgang Bär', comment:'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonum' }
                 , {name:'Tina Lischen', comment:'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonum' }
                 , {name:'Ulf Paul', comment:'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy ei' }
                 , {name:'Paul Laufland', comment:'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonu' }
                 , {name:'Otto Kay', comment:'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy ei' } ] },

    {  writer:'Peter Paul'
    , date:'vor zwei Tagen'
    , text: 'ed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.'
    , comments:[  {name:'Hans Müller', comment:'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy' }
    , {name:'Wolfgang Bär', comment:'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonum' }
    , {name:'Tina Lischen', comment:'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonum' }
    , {name:'Ulf Paul', comment:'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy ei' }
    , {name:'Paul Laufland', comment:'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonu' }
    , {name:'Otto Kay', comment:'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy ei' } ] }
  ]

  controller = (scope, templateCache) ->
    console.log 'called jammerKastenController'
    weekNo = 0

    setupWeeks = (year = new Date().getFullYear(), week) ->
      if typeof year is 'number'
        d = new Date "#{year}-01-01 00:00:00"
      else
        d = year

      d.setHours(0,0,0)

      d.setDate(d.getDate() + 4 - (d.getDay()||7))
      yearStart = new Date d.getFullYear(),0,1
      weekNo = Math.ceil(( ( (d - yearStart) / 86400000) + 1)/7)

      weekNo = week if week?

      scope.notes = data

      scope.weekNo = weekNo # = 1
      scope.yearNo = if typeof year is 'number' then year else year.getFullYear()
      scope.weekNos = []
      scope.weekNos = ( {weekNo:n, notes:Math.floor(Math.random() * 10)} for n in [1+weekNo..52]) if weekNo < 52

      scope.weekNos.unshift {weekNo:1, notes:Math.floor(Math.random() * 10)}  if weekNo isnt 1

    setupWeeks new Date()

#    ($ 'DIV#notesArea').append $ templateCache.get 'oneThing'

    scope.prevWeek = () ->
      if scope.weekNo is 1
        setupWeeks scope.yearNo-1, 52
      else
        setupWeeks scope.yearNo, scope.weekNo-1

    scope.nextWeek = () ->
        if scope.weekNo is 52
          setupWeeks scope.yearNo+1, 1
        else
          setupWeeks scope.yearNo, scope.weekNo+1

    bMouseDown = false
    scope.noteMouseDown = ($event) ->
      $event.preventDefault()
      bMouseDown = true if $event.which is 1


    scope.noteMouseUp = () -> bMouseDown = false
    scope.noteMouseLeave=()-> bMouseDown = false


    scope.noteMouseMove = ($event, note) ->
      return if not bMouseDown

      console.log $event.webkitMovementX
      console.log $event.webkitMovementY
      $elem = ($ event.target).parent()
      offset= $elem.offset()
      offset.left = 0 if offset.left < 0
      offset.top  = 0 if offset.top  < 0
      $elem.css {left:offset.left+$event.webkitMovementX, top:offset.top+$event.webkitMovementY, right:''}

      return undefined


    scope.selectedWeek = (week) ->
      tmp = []
      tmp = ( {weekNo:n, notes:Math.floor(Math.random() * 10)} for n in [1+week.weekNo..52]) if week.weekNo < 52
      tmp.unshift {weekNo:1, notes:Math.floor(Math.random() * 10)}
      scope.weekNo = week.weekNo
      scope.weekNos = tmp






  console.log 'defined jammerKastenController'
  return ['$scope', '$templateCache', controller]
