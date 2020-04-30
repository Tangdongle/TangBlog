include karax/prelude
import navlinkbar

const
  LOGOPATH = "img/logo.png"
  LOGO_WIDTH = "145".cstring
  LOGO_HEIGHT = "146".cstring

var links: seq[tuple[slug: cstring, title: cstring]] = @[("http://0.0.0.0:5000/".cstring, "Home Page".cstring), ("http://0.0.0.0:5000/post/Test".cstring, "Test Post".cstring)]

proc logo(): VNode =
  result = buildHtml(tdiv(class = "col-5 logo")):
    img(src = LOGOPATH, alt = "Tongirs Stuff", height = LOGO_HEIGHT, width = LOGO_WIDTH)

proc renderHeader*(): VNode =
  result = buildHtml(tdiv(class = "col-1", id = "header")):
    header(class = "grid-column"):
      logo()
      navlinkbar(links)
