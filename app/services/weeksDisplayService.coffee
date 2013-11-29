define []
, () ->
  class weeksDisplayService
    constructor: () ->
      @weekNo = 0

    setup: (scope, year = new Date(), week) ->
        if typeof year is 'number'
          d = new Date   year, 0, 1
          scope.yearNo = year
        else
          d = year
          scope.yearNo = year.getFullYear()

        if week? then @weekNo = week
        else          @weekNo   = @getCurrentWeek d

        @selectedWeek scope, {weekNo: @weekNo}

    getList: (year, week) ->
      if week is 0
        year--
        week = 52
      if 52 < week
        year++
        week = 1

      tmp = []
      tmp.push n for n in [1+week..52] if week < 52
      tmp.unshift 1 if week.weekNo isnt 1
      return {weeks:tmp, year:year, week:week}

    generateDropdown: (list, notes = []) -> ({weekNo:week, notes:if notes[i]? then notes[i] else 0} for week,i in list.weeks)

    selectedWeek: (scope, week) ->
        tmp = []
        tmp = ( {weekNo:n, notes:0} for n in [1+week.weekNo..52]) if week.weekNo < 52
        tmp.unshift {weekNo:1, notes:0} if week.weekNo isnt 1
        scope.weekNo = week.weekNo
        scope.weekNos = tmp

    getCurrentWeek: (d = new Date()) ->
      date = new Date d
      date.setHours(0,0,0)
      date.setDate(date.getDate() + 4 - (d.getDay() || 7))
      yearStart = new Date d.getFullYear(), 0, 1
      return Math.ceil(( ( (date - yearStart) / 86400000) + 1)/7)



  console.log 'defined weeksDisplayService'
  weeksDisplayService