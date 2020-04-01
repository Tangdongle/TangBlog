# This is just an example to get you started. A typical hybrid package
# uses this file as the main entry point of the application.

import wapphpkg/render
import jester
import htmlgen

routes:
  get "/":
    resp h1("Hello World")

  get "/post/@id":
    resp render.render(parseInt(@"id"))
