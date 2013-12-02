
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
  
  <button type="button" class="btn btn-default pull-right" data-ng-click="openCreateNote()"><span class="glyphicon glyphicon-plus"></span></button>

  <div id="notesArea">
    <div class="panel panel-default" data-note-move data-ng-repeat="note in notes" style="position:absolute;" data-ng-style="note.position">
      <div style="cursor:pointer;" data-ng-style="note.style" class="panel-heading">
        {{note.writer}} | {{note.date}}
        <p>{{ note.caption }}</p>
      </div>
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
    templateCache.put 'modalCreateNote', """
<div class="modal fade" id="modalCreateNote" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title" id="myModalLabel">Neue Notiz</h4>
      </div>
      <div class="modal-body">
        <div class="form-group">
          <input    class="form-control" type="text" placeholder="Überschrift">
        </div>
        <div clasl="form-group">
          <textarea class="form-control" rows="5"></textarea>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-ng-click="cancel()">Abbrechen</button>
        <button type="button" class="btn btn-primary" data-ng-click="ok()" data-dismiss="modal">Erstellen</button>
      </div>
    </div>
  </div>
</div>
"""
  ]