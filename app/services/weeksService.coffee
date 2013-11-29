define []
, () ->
  class weeksDisplayService
    constructor: () ->

    getCurrentWeek: (d = new Date()) ->
      date = new Date d
      date.setHours(0,0,0)
      date.setDate(date.getDate() + 4 - (d.getDay() || 7))
      yearStart = new Date d.getFullYear(), 0, 1
      return Math.ceil(( ( (date - yearStart) / 86400000) + 1)/7)

    getMaxWeek: (d= new Date("#{new Date().getFullYear()}-12-31")) ->
      return @getCurrentWeek d


  console.log 'defined weeksDisplayService'
  weeksDisplayService