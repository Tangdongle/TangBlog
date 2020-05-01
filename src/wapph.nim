# This is just an example to get you started. A typical hybrid package
# uses this file as the main entry point of the application.

import wapphpkg/render
import jester
import norm
import htmlgen, json
import wapphpkg/[dbutils, models]

routes:
  get "/":
    resp render.render("home")

  get "/post/@slug":
    resp render.render(@"slug")

  get "/aside/for_page_id/@id":
    let aside = asideForPageId(parseInt(@"id"))
    resp $(aside), "application/json"

  post "/pages":
    withDB:
      let pages = Page.getAll()
      resp $(%pages), "application/json"
