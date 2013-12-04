
define ['app', 'jquery', 'filters/wikipediaUrlFilter']
, (app, $) ->

  directive = (filter, compile) ->
    return {

    link: (scope, element, attrs) ->
      console.log 'textWithWikipedia'
#      console.dir scope
#      console.dir element
#      console.dir attrs

      $html = ($ "<DIV>#{filter('wikipediaUrl') scope.note.text}</DIV>")

      console.dir $html


      $html.find('A').each () ->
        $a = ($ this)
        url = $a.attr 'href'
        $a.removeAttr 'href'
        $a.removeAttr 'target'
        $a.attr 'data-wikipedia-overlay', url

      # console.dir ($ '<DIV></DIV').append($html).html()

      compile($html) scope
      element.append $html

    }

  console.log 'defined textWithWikipediaDirective'
  app.directive 'textWithWikipedia', ['$filter', '$compile', directive]
  undefined