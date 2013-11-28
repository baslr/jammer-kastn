fs = require 'fs'
io = require('socket.io').listen 3344

data = require './data.json'

console.dir data

io.sockets.on 'connection', (socket) ->
  console.log "SOCK -> CON #{socket.handshake.address.address}"
  socket.emit 'msg', 'batz'

  socket.on 'get-notes', (obj) ->
    console.log 'socket.on:get-notes'
    console.dir obj
    if data[obj.year]?[obj.week]?
      socket.emit 'set-notes', data[obj.year][obj.week]
      console.log 'socket.emit:set-notes'

  socket.on 'set-note', (noteIn) ->
    console.log 'socket.on set-note'
    noteIn = JSON.parse noteIn if typeof noteIn is 'string'

    for year,n of data
      for week,nn of n
        for note,i in nn
          if note.date   is noteIn.date   and
             note.writer is noteIn.writer and
             note.text   is noteIn.text
               console.log 'set-note'
               data[year][week][i] = noteIn


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