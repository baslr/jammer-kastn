page = require('webpage').create()

args = require('system').args

url = decodeURIComponent args[1]

page.settings.userAgent = 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/31.0.1650.57 Safari/537.36';

page.viewportSize = { width: 1024, height: 2000 }

wikiPageReadabilityHtml = (url, cb) ->
  page.open url, (status) ->
    # page.render("test.png")
    page.injectJs 'vendor/js/jquery-2-0-3.js'
    page.injectJs 'safari-reader.js'

    a = page.evaluate () ->
      reader = window.ReaderArticleFinderJS

      return false if ! reader.isReaderModeAvailable()

      reader.prepareToTransitionToReader()

      adopArticle = reader.adoptableArticle(true)

      divN = document.createElement("div")
      divN.className="page"

      divR = document.createElement("div")
      divR.className = "page-number"
      divN.appendChild( divR)

      h1 = document.createElement("h1")
      h1.className   = "title"
      h1.textContent = reader.articleTitle()
      divN.appendChild(h1)

      while(adopArticle.firstChild)
        divN.appendChild(adopArticle.firstChild)

      $art = ($ '<BODY></BODY>')
      $art.append ($ '<DIV id="article"></DIV>').append divN

      return $art.html()  # 'fups' # JSON.stringify console.dir $art

    cb a

wikiPageReadabilityHtml url, (html) ->

  pat = /<span><span>\[[^\]]+\]<\/span><\/span>/ig

  txt    = ''
  offset = 0

  html2 = html.slice()

  while test = pat.exec html
#    console.dir "#{test.index} #{test[0].length}"

    html2 = html2.replace(test[0], '')
#    txt +=  html.substr offset, test.index-offset

#    offset += Number test[0].length+test.index


#  txt += html.slice offset


  console.dir html2

  phantom.exit()


# https://en.wikipedia.org/wiki/Riverworld