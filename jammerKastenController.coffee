
define []
        , () ->

  controller = (scope) ->
    console.log 'called jammerKastenController'

    d = new Date()
    d.setHours(0,0,0)

    d.setDate(d.getDate() + 4 - (d.getDay()||7))
    yearStart = new Date d.getFullYear(),0,1
    weekNo = Math.ceil(( ( (d - yearStart) / 86400000) + 1)/7)

    scope.weekNo = weekNo = 1
    scope.yearNo = new Date().getFullYear()

    scope.weekNos = (n for n in [1+weekNo..52])

    scope.hideWeekNos = true

    scope.showWeeks = () ->
      scope.hideWeekNos = ! scope.hideWeekNos

    scope.selectedWeek = (week) ->
      tmp = (n for n in [1+week..52])
      tmp.unshift weekNo
      scope.weekNo = week
      scope.weekNos = tmp




  console.log 'defined jammerKastenController'
  return ['$scope', controller]
