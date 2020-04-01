import norm
import models
import tables
import strutils
import os

const STATIC_DIR = "./public/compiled"

proc buildHeader(): string =
  result.add """<!DOCTYPE html><html><head>"""
  result.add("""<title>$#</title>""")

  for css_file in os.walkFiles(STATIC_DIR / "*.css"):
    let (dir, css_filename, extension) = css_file.splitFile()
    echo "Adding $#" % css_filename
    result.add("""<link rel="stylesheet" href="http://0.0.0.0:5000/$#" />""" % (dir.split("/")[^1] / css_filename & extension))

  result.add("""</head>""")

let HEADER = buildHeader()

type
  TPL = ref object of RootObj
    header: string
    footer: string

proc newTpl(): TPL =
  new result
  result.header = """<header><h2>$#</h2></header><body>"""
  result.footer = """<footer></footer>"""

proc renderPage(page: Page, tpl = newTpl()): string =
  ## Render a Page object

  result.add("""<body><div class="grid-12"><div class="col-2"></div><div class="col-8">""")
  result.add(tpl.header % page.title)

  result.add("""<article>$#</article>""" % page.content)

  result.add(tpl.footer)
  result.add("""</div><div class="col-2"></div></div></body>""")

proc render404(tpl = newTpl()): string =
  result.add(tpl.header % "Post doesn't exist")
  result.add("""<div><article>$#</article></div>""" % "Post doesn't exist")
  result.add(tpl.footer)

proc render*(id: int): string =
  withDb:

    try:
      let page = Page.getOne(id)
      result.add(HEADER % page.title)
      echo "Added header: " & HEADER
      result.add(renderPage(page))
    except KeyError:
      result.add(HEADER % "Post Doesn't Exist")
      result.add(render404())

    result.add("""</html>""")

export models
