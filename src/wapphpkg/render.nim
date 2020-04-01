import norm
import models
import tables
import strutils

const HEADER = """<!DOCTYPE html>
  <html>
  <head>
  <title>$#</title>
  </head>"""

type
  TPL = ref object of RootObj
    header: string
    footer: string

proc newTpl(): TPL =
  new result
  result.header = """<header><h2>$#</h2></header>"""
  result.footer = """<footer></footer>"""

proc renderPage(page: Page, tpl = newTpl()): string =
  ## Render a Page object

  if tpl.header.len > 0:
    result.add(tpl.header % page.title)

  result.add("""<article>$#</article>""" % page.content)

  if tpl.footer.len > 0:
    result.add(tpl.footer)

proc render404(tpl = newTpl()): string =
  result.add(tpl.header % "Post doesn't exist")
  result.add("""<article>$#</article>""" % "Post doesn't exist")
  result.add(tpl.footer)

proc render*(id: int): string =
  withDb:

    try:
      let page = Page.getOne(id)
      result.add(HEADER % page.title)
      result.add(renderPage(page))
    except KeyError:
      result.add(HEADER % "Post Doesn't Exist")
      result.add(render404())

    result.add("""</html>""")

export models
