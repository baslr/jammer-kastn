
define ['app', 'jquery']
, (app, $) ->

  directive = () ->
    return {

    scope: { wikipediaOverlay: '@' }

    link: (scope, element, attrs) ->
      console.log 'wikipedia-overlay'

      modal = """<div class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog" style="width:1000px;">
              <div class="modal-content">
                <div class="modal-body"></div>
                <div class="modal-footer">
                  <button type="button" class="btn btn-default" data-dismiss="modal">Schließen</button>
                </div>
              </div>
            </div>
          </div>"""

      $modal = ($ modal)

      element.on 'click', () ->
        url = scope.wikipediaOverlay

        $.get "/wiki/#{encodeURIComponent url}", (html) ->
          wikiUrl = url.slice 0, url.toLowerCase().match(/^https?:\/\/[a-z]{1,4}\.wikipedia\.org/)[0].length
          $modal.find('DIV.modal-body').append ($ html)
          $modal.find('A').each () ->
            wUrl = ($ this).attr 'href'

            if -1 is wUrl.search /^http/
              ($ this).attr {href:"#{wikiUrl}#{wUrl}",target:'_blank'}

          ($ 'BODY').append $modal
          $modal.modal()

      scope.$on '$destroy', () ->
        $modal.remove()
        element.off()
        undefined
    }

  console.log 'defined wikipediaOverlayDirective'
  app.directive 'wikipediaOverlay', directive
  undefined