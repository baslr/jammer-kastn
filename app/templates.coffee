
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
  <button type="button" class="btn btn-default pull-right" data-ng-click="openCreateUser()">Neuer Nutzer <span class="glyphicon glyphicon-plus"></span></button>

  <div id="notesArea">
    <div class="panel panel-default" data-note-move data-ng-repeat="note in notes" style="position:absolute;" data-ng-style="note.position">
      <div style="cursor:pointer;" data-ng-style="note.style" class="panel-heading">
        {{note.writer}} | {{note.date}}
        <p><b>{{ note.caption }}</b></p>
      </div>
      <div class="panel-body">
        <div data-text-with-wikipedia="note.text"></div>
        <button class="btn btn-block btn-default btn-xs" style="text-align: center;" data-ng-click="showHideNote(note)">{{ note.comments.length }} Kommentare</button>
        <ul class='list-unstyled' style="max-height: 200px; overflow-y: scroll;" data-ng-hide="note.hide">
          <li ng-repeat="user in note.comments">
            <b data-ng-style="user.style">{{user.name}}</b>
            <span data-text-with-wikipedia="user.comment"></span>
          </li>
        </ul>
        <textarea data-comment-note placeholder="Kommentieren" class="form-control" style='margin-top:3px;'></textarea>
      </div>
    </div>
  </div>
</div>"""
    templateCache.put 'modalCreateNote', """
        <div class="form-group">
          <input    class="form-control" type="text" placeholder="Überschrift">
        </div>
        <div clasl="form-group">
          <textarea class="form-control" rows="5"></textarea>
        </div>"""

    templateCache.put 'modalCreateUser', """
        <div class="form-group">
          <input    class="form-control" type="text" placeholder="Name">
        </div>
        <div clasl="form-group">
          <select class="form-control" onchange="this.style.backgroundColor = this.value;"><option value="#123456" style="background-color: #123456"></option>
                                       <option value="#ffdd00" style="background-color: #ffdd00"></option></select>
        </div>"""

    templateCache.put 'modalDialog', """
<div class="modal fade" id="modalDialog" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title" id="myModalLabel">Neue Notiz</h4>
      </div>
      <div class="modal-body"></div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-ng-click="cancel()">Abbrechen</button>
        <button type="button" class="btn btn-primary" data-ng-click="ok()" data-dismiss="modal">{{okLabel}}</button>
      </div>
    </div>
  </div>
</div>"""
  ]