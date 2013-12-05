
define ['app', 'jquery', 'filters/wikipediaUrlFilter']
, (app, $) ->

  directive = (filter, compile) ->
    return {

    scope: { textWithWikipedia: '=' }

    link: (scope, element, attrs) ->
      console.log 'textWithWikipedia'

      $html = ($ "<SPAN>#{filter('wikipediaUrl') scope.textWithWikipedia}</SPAN>")

      $html.find('A').each () ->
        $a = ($ this)
        url = $a.attr 'href'
        $a.removeAttr 'href'
        $a.removeAttr 'target'
        $a.attr 'data-wikipedia-overlay', url

      compile($html) scope
      element.append $html

    }

  console.log 'defined textWithWikipediaDirective'
  app.directive 'textWithWikipedia', ['$filter', '$compile', directive]
  undefined