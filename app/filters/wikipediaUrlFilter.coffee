
define [ ]
        , () ->

  return () ->
    return (origTxt = '') ->

      workTxt = origTxt.slice()
      pat     = /[^\ ]+\.wikipedia\.org\/[^\ ]+/g

      while test = pat.exec workTxt
        wikiLink = plainWikiLink = workTxt.substr test.index, test[0].length

        txtPat = /\.wikipedia\.org\/wiki\//ig
        txtPat.exec plainWikiLink


        if -1 is plainWikiLink.search /^https?:\/\//
          wikiLink = 'https://'+wikiLink

        else if 0 is plainWikiLink.search /^http:\/\//
          wikiLink = 'https'+ plainWikiLink.slice 4

        origTxt = origTxt.replace plainWikiLink, "<a href=\"#{wikiLink}\" target=\"_blank\">#{decodeURIComponent plainWikiLink.slice txtPat.lastIndex}</a>"

      return origTxt
