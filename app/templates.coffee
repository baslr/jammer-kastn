
define ['app']
        , (app) ->
  app.run ['$templateCache', (templateCache) ->
    console.log 'app.run:templateCache'
    templateCache.put 'view1.html', """
<div>
  <nav class="navbar navbar-default" role="navigation">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand">JammerKasten</a>
    </div>
  
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
      <form class="navbar-form navbar-left">
          <div class="btn-group">
            <button type="button" class="btn btn-default" data-ng-click="prevWeek()"><span class="glyphicon glyphicon-chevron-left"></span></button>
            <button data-toggle="dropdown" class="btn btn-default" data-ng-click="showWeeks()">{{ currentWeek }}. KW {{ currentYear }}</button>
            <ul class="dropdown-menu" role="menu" aria-labelledby="dLabel">
              <li data-ng-repeat="week in weeksDropdown" data-ng-click="selectedWeek(week)"><a>{{ week.weekNo }}. KW <span class="badge">{{ week.notes }}</span></a></li>
            </ul>
            <button type="button" class="btn btn-default" data-ng-click="nextWeek()"><span class="glyphicon glyphicon-chevron-right"></span></button>
          </div>
      </form>

      <ul class="nav navbar-nav navbar-right">
        <li><a href="#">Link</a></li>
        <li class="dropdown">
          <a class="dropdown-toggle" data-toggle="dropdown">News <b class="caret"></b></a>
          <ul class="dropdown-menu">
            <li><a href="#">Action</a></li>
            <li><a href="#">Another action</a></li>
            <li><a href="#">Something else here</a></li>
            <li class="divider"></li>
            <li><a href="#">Separated link</a></li>
          </ul>
        </li>
        <form class="navbar-form navbar-right">
          <div class="form-group">
            <button type="button" class="btn btn-default" data-ng-click="openCreateUser()">Neuer Nutzer <span class="glyphicon glyphicon-plus"></span></button>
          </div>
          <div class="form-group">
            <button type="button" class="btn btn-default" data-ng-click="openCreateNote()"><span class="glyphicon glyphicon-plus"></span></button>
          </div>
        </form>
      </ul>
    </div><!-- /.navbar-collapse -->
  </nav>

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
          <input    class="form-control" type="text" id="userName" placeholder="Name">
        </div>
        <div class="form-group">
          <input    class="form-control" type="text" id="emailAddress" placeholder="E-Mail-Ad­res­se">
        </div>
        <div clasl="form-group">
          <div class="dropdown">
            <button id="userColorButton" class="btn btn-default" data-toggle="dropdown" style="width:100%;">Nutzerfarbe</button>
            <ul class="dropdown-menu" role="menu" aria-labelledby="dLabel" style="width:100%;">
              <li style="background-color: #98b5f3; height:30px; cursor:pointer;" onclick="$('BUTTON#userColorButton')[0].style.backgroundColor = this.style.backgroundColor"   >&nbsp;</li>
              <li style="background-color: #a3ccc5; height:30px; cursor:pointer;" onclick="$('BUTTON#userColorButton')[0].style.backgroundColor = this.style.backgroundColor"   >&nbsp;</li>
              <li style="background-color: #cacfde; height:30px; cursor:pointer;" onclick="$('BUTTON#userColorButton')[0].style.backgroundColor = this.style.backgroundColor"   >&nbsp;</li>
              <li style="background-color: #cae1ab; height:30px; cursor:pointer;" onclick="$('BUTTON#userColorButton')[0].style.backgroundColor = this.style.backgroundColor"   >&nbsp;</li>
              <li style="background-color: #dba3ef; height:30px; cursor:pointer;" onclick="$('BUTTON#userColorButton')[0].style.backgroundColor = this.style.backgroundColor"   >&nbsp;</li>
              <li style="background-color: #f2b9af; height:30px; cursor:pointer;" onclick="$('BUTTON#userColorButton')[0].style.backgroundColor = this.style.backgroundColor"   >&nbsp;</li>
              <li style="background-color: #f9f4a6; height:30px; cursor:pointer;" onclick="$('BUTTON#userColorButton')[0].style.backgroundColor = this.style.backgroundColor"   >&nbsp;</li>
              <li style="background-color: #bef7ed; height:30px; cursor:pointer;" onclick="$('BUTTON#userColorButton')[0].style.backgroundColor = this.style.backgroundColor"   >&nbsp;</li>
              <li style="background-color: #dab6a9; height:30px; cursor:pointer;" onclick="$('BUTTON#userColorButton')[0].style.backgroundColor = this.style.backgroundColor"   >&nbsp;</li>
            </ul>
          </div>
        </div>"""

    templateCache.put 'modalDialog', """
<div class="modal fade" id="modalDialog" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title" id="myModalLabel">{{title}}</h4>
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