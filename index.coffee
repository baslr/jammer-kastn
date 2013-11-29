fs = require 'fs'
io = require('socket.io').listen 3344

data = require './data.json'

console.dir data

getNote = (id) ->
  for year,n of data
    for week,nn of n
      for note,i in nn
        return data[year][week][i] if note.id is id

getNotesForWeek = (year, week) -> data[year][week] if data[year]?[week]?

getCurrentWeek = (d = new Date()) ->
    date = new Date d
    date.setHours(0,0,0)
    date.setDate(date.getDate() + 4 - (d.getDay() || 7))
    yearStart = new Date d.getFullYear(), 0, 1
    return Math.ceil(( ( (date - yearStart) / 86400000) + 1)/7)

getMaxWeek = (d= new Date("#{new Date().getFullYear()}-12-31")) ->
    return getCurrentWeek d


io.sockets.on 'connection', (socket) ->
  console.log "SOCK -> CON #{socket.handshake.address.address}"
  socket.emit 'msg', 'batz'

  socket.on 'get-notes', (obj) ->
    console.log 'socket.on:get-notes'
    console.dir obj
    if data[obj.year]?[obj.week]?
      socket.emit 'set-notes', data[obj.year][obj.week]
      console.log 'socket.emit:set-notes'

  socket.on 'set-position', (data) ->
    console.log '.on set-position'
    note = getNote data.id
    if note?
      note.position.left = data.pos.left
      note.position.top  = data.pos.top

  socket.on 'set-index', (data) ->
    console.log '.on set-index'
    note = getNote data.id
    if note?
      note.position['z-index'] = data.index

  socket.on 'get-dropdown', (data) ->
    console.log '.on get-dropdown'
    console.dir  data
    week = data.week
    year = data.year
    maxWeek = getMaxWeek new Date "#{year}-12-31"
    tmp  = []

    tmp.push n for n in [1+week..maxWeek] if week < maxWeek
    tmp.unshift 1 if week isnt 1

    dropDown = for week,i in tmp
      notes = getNotesForWeek year, week

      {weekNo:week, notes:if notes? then notes.length else 0}

    socket.emit 'set-dropdown', dropDown





setInterval () ->
  fs.writeFileSync 'data.json', JSON.stringify data
, 10 * 1000


###
data = {2013:{1:  [ { position:{left:'200px',top:'10px', 'z-index':1}, writer:'Peter Paul'
, date:'vor zwei Tagen'
, text: 'ed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.'
, comments:[  {name:'Hans Müller', comment:'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy' }
  , {name:'Wolfgang Bär', comment:'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonum' }
  , {name:'Tina Lischen', comment:'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonum' }
  , {name:'Ulf Paul', comment:'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy ei' }
  , {name:'Paul Laufland', comment:'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonu' }
  , {name:'Otto Kay', comment:'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy ei' } ] },

  { position:{left:'210px',top:'45px','z-index':2}, writer:'Peter Paul'
  , date:'vor zwei Tagen'
  , text: 'ed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.'
  , comments:[  {name:'Hans Müller', comment:'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy' }
  , {name:'Wolfgang Bär', comment:'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonum' }
  , {name:'Tina Lischen', comment:'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonum' }
  , {name:'Ulf Paul', comment:'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy ei' }
  , {name:'Paul Laufland', comment:'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonu' }
  , {name:'Otto Kay', comment:'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy ei' } ] },

  { position:{left:'220px',top:'80px','z-index':3}, writer:'Qwertz'
  , date:'Drölf Tage davor'
  , text: 'ed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.'
  , comments:[  {name:'Hans Müller', comment:'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy' }
  , {name:'Otto Kay', comment:'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy ei' } ] } ]}
, 2014:{1:  [ { position:{left:'200px',top:'10px', 'z-index':1}, writer:'Peter Paul'
  , date:'vor zwei Tagen, 2013'
  , text: 'ed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.'
  , comments:[  {name:'Hans Müller', comment:'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy' }
    , {name:'Wolfgang Bär', comment:'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonum' }
    , {name:'Tina Lischen', comment:'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonum' }
    , {name:'Ulf Paul', comment:'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy ei' }
    , {name:'Paul Laufland', comment:'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonu' }
    , {name:'Otto Kay', comment:'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy ei' } ] },

    { position:{left:'210px',top:'45px', 'z-index':2}, writer:'Peter Paul'
    , date:'vor drölf Tagen, 2013'
    , text: 'ed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.'
    , comments:[  {name:'Hans Müller', comment:'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy' }
    , {name:'Wolfgang Bär', comment:'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonum' }
    , {name:'Tina Lischen', comment:'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonum' }
    , {name:'Ulf Paul', comment:'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy ei' }
    , {name:'Paul Laufland', comment:'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonu' }
    , {name:'Otto Kay', comment:'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy ei' } ] }]}
}
###