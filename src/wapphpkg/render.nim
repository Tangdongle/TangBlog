import norm
import models
import tables
import strutils
import os
import moustachu

const STATIC_DIR = "./public/compiled"

var baseTpl ="""
<!DOCTYPE html>
<html>
  <head>
    <title>{{title}}</title>
    {{#css_links}}
      <link rel="stylesheet" href="http://0.0.0.0:5000/{{.}}" />
    {{/css_links}}
  </head>
  <body>
    <div class="grid-12">
      <div class="col-2"></div>
      <div class="col-8">
        <header><h2>{{title}}</h2></header>
        <article>{{main_content}}</article>
        <footer></footer>
      </div>
      <div class="col-2"></div>
    </div>
  </body>
</html>
"""

proc buildCssLinks(): seq[string] =
  for css_file in os.walkFiles(STATIC_DIR / "*.css"):
    let (dir, css_filename, extension) = css_file.splitFile()
    echo "Adding " & css_filename
    result.add(dir.split("/")[^1] / css_filename & extension)

proc render*(id: int): string =
  withDb:

    try:
      let page = Page.getOne(id)
      var context: Context = newContext()
      context["title"] = page.title
      context["css_links"] = buildCssLinks()
      context["main_content"] = page.content
      result = render(baseTpl, context)
      echo result
    except KeyError:
      var context: Context = newContext()
      context["title"] = "Can't find post"
      context["css_links"] = buildCssLinks()
      context["main_content"] = "Post doesn't exist"
      result = render(baseTpl, context)

export models
