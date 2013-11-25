
define []
        , () ->

  controller = (scope) ->
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


      scope.weekNo = weekNo # = 1
      scope.yearNo = if typeof year is 'number' then year else year.getFullYear()
      scope.weekNos = []
      scope.weekNos = ( {weekNo:n, notes:Math.floor(Math.random() * 10)} for n in [1+weekNo..52]) if weekNo < 52

      scope.weekNos.unshift {weekNo:1, notes:Math.floor(Math.random() * 10)}  if weekNo isnt 1

    setupWeeks new Date()

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


    scope.selectedWeek = (week) ->
      tmp = []
      tmp = ( {weekNo:n, notes:Math.floor(Math.random() * 10)} for n in [1+week.weekNo..52]) if week.weekNo < 52
      tmp.unshift {weekNo:1, notes:Math.floor(Math.random() * 10)}
      scope.weekNo = week.weekNo
      scope.weekNos = tmp






  console.log 'defined jammerKastenController'
  return ['$scope', controller]
