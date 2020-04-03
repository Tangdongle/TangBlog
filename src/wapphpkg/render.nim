import norm
import models
import tables
import strutils
import os
import json
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
    <div class="grid-8">
      <div class="col-2">
        <div class="grid-8">
          <div class="col-2">
            {{logo}}
          </div>
          <div class="col-6">
            <nav><ul>
            {{#nav}}
              <li><a href="http://0.0.0.0:5000/post/{{url}}">{{name}}</a></li>
            {{/nav}}
            </ul></nav>
          </div>
        </div>
      </div>
      <div class="col-6">
        <div class="grid-5">
          <div class="col-3">
            <header><h2>{{title}}</h2></header>
            <article>{{main_content}}</article>
            <footer></footer>
          </div>
          <div class="col-1"></div>
        </div>
      </div>
    </div>
  </body>
</html>
"""

proc buildNavLinks(): JsonNode =
  ## Build nav URLS
  result = newJArray()
  withDb:
    let pages = Page.getAll()
    for page in pages:
      var newObj = newJObject()
      newObj["url"] = newJString(page.slug)
      newObj["name"] = newJString(page.title)
      result.add(newObj)

proc buildCssLinks(): seq[string] =
  ## Build a list of CSS paths to import

  for css_file in os.walkFiles(STATIC_DIR / "*.css"):
    let (dir, css_filename, extension) = css_file.splitFile()
    echo "Adding " & css_filename
    result.add(dir.split("/")[^1] / css_filename & extension)

proc render(page: Page): string =
  var context: Context = newContext()
  context["title"] = page.title
  context["css_links"] = buildCssLinks()
  context["main_content"] = page.content
  context["nav"] = buildNavLinks()

  result = render(baseTpl, context)

proc render404(): string =
  var context: Context = newContext()
  context["title"] = "Can't find post"
  context["css_links"] = buildCssLinks()
  context["main_content"] = "Post doesn't exist"
  result = render(baseTpl, context)

proc render*(id: int): string =
  ## Get page by ID

  withDb:
    try:
      let page = Page.getOne(id)
      return render(page)
    except KeyError:
      return render404()

proc render*(slug: string): string =
  ## Get page by slug

  withDb:
    try:
      let page = Page.getOne("slug = $1", slug)
      return render(page)
    except KeyError:
      return render404()

export models
