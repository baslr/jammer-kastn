
define ['app']
        , (app) ->
  app.run ['$templateCache', (templateCache) ->
    console.log 'app.run:templateCache'
    templateCache.put 'view1.html', """
<div>
  <div class="btn-group">
    <button type="button" class="btn btn-default" data-ng-click="prevWeek()"><span class="glyphicon glyphicon-chevron-left"></span></button>
    <button data-toggle="dropdown" class="btn btn-default" data-ng-click="showWeeks()">{{ currentWeek }}. KW {{ currentYear }}</button>
    <ul class="dropdown-menu" role="menu" aria-labelledby="dLabel">
      <li data-ng-repeat="week in weeksDropdown" data-ng-click="selectedWeek(week)"><a>{{ week.weekNo }}. KW <span class="badge">{{ week.notes }}</span></a></li>
    </ul>
    <button type="button" class="btn btn-default" data-ng-click="nextWeek()"><span class="glyphicon glyphicon-chevron-right"></span></button>
  </div>
  
  <button type="button" class="btn btn-default pull-right" data-ng-click="newNote()"><span class="glyphicon glyphicon-plus"></span></button>

  <div id="notesArea">
    <div class="panel panel-default" data-note-move data-ng-repeat="note in notes" style="position:absolute;" data-ng-style="note.position">
      <div style="cursor:pointer;" data-ng-style="note.style" class="panel-heading">{{note.writer}} | {{note.date}}</div>
      <div class="panel-body">
        {{ note.text }}
        <p><center>{{ note.comments.length }} Kommentare</center></p>
        <dl style="max-height: 200px; overflow-y: scroll;">
          <dt ng-repeat-start="user in note.comments" data-ng-style="user.style" style="padding-left:10px;">{{user.name}}</dt>
          <dd ng-repeat-end>{{ user.comment }}</dd>
        </dl>
      </div>
    </div>
  </div>
</div>
"""
    templateCache.put 'view2.html', """
<h2>view 2</h2>

<ul>
  <li ng-repeat="bar in bars"> {{ bar }}
</ul>

<a href="#view1">back </a>"""

    templateCache.put 'oneThing', """
<div class="panel panel-default">
  <div class="panel-heading">Peter Paul | vor zwei Tagen</div>
  <div class="panel-body">
Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.
  <dl>
    <dt>Hans Müller</dt>
    <dd>Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat</dd>
    <dt>Wolfgang Bär</dt>
    <dd>Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat</dd>
    <dt>Tina Lischen</dt>
    <dd>Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat</dd>
    <dt>Ulf Paul</dt>
    <dd>Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat</dd>
    <dt>Paul Laufland</dt>
    <dd>Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat</dd>
    <dt>Otto Kay</dt>
    <dd>Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat</dd>
  </dl>
  </div>
</div>
"""
  ]