# This is just an example to get you started. A typical hybrid package
# uses this file as the main entry point of the application.

import wapphpkg/render
import jester
import htmlgen

routes:
  get "/":
    resp render.render("home")

  get "/post/@slug":
    resp render.render(@"slug")
