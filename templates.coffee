
define ['app']
        , (app) ->
  app.run ['$templateCache', (templateCache) ->
    console.log 'app.run:templateCache'
    templateCache.put 'view1.html', """
<div>
  <div class="btn-group">
    <button type="button" class="btn btn-default" data-ng-click="prevWeek()"><span class="glyphicon glyphicon-chevron-left"></span></button>
    <button data-toggle="dropdown" class="btn btn-default" data-ng-click="showWeeks()">{{ weekNo }} KW {{ yearNo }}</button>
    <ul class="dropdown-menu" role="menu" aria-labelledby="dLabel">
      <li data-ng-repeat="weekNo in weekNos" data-ng-click="selectedWeek(weekNo)"><a>{{ weekNo.weekNo }} KW <span class="badge">{{ weekNo.notes }}</span></a></li>
    </ul>
    <button type="button" class="btn btn-default" data-ng-click="nextWeek()"><span class="glyphicon glyphicon-chevron-right"></span></button>
  </div>

  <h2>view1</h2>
  
  Name:<br />
  <form name="testForm" ng-submit="add()">
    <input type="text" ng-model="name" /><br />
    <input type="submit" value="add" />
  </form>

  <ul>
    <li ng-repeat="cust in customers"> {{ cust.name }}
  </ul>

  <a href="#/view2"> view 2</a>
</div>
"""
    templateCache.put 'view2.html', """
<h2>view 2</h2>

<ul>
  <li ng-repeat="bar in bars"> {{ bar }}
</ul>

<a href="#view1">back </a>"""
  ]