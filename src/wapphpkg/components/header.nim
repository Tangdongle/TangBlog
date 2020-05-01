include karax/prelude
import navlinkbar
import models

const
  LOGOPATH = "/img/logo.png"
  LOGO_WIDTH = "145".cstring
  LOGO_HEIGHT = "146".cstring

proc logo(): VNode =
  result = buildHtml(tdiv(class = "col-5 logo")):
    img(src = LOGOPATH, alt = "Tongirs Stuff", height = LOGO_HEIGHT, width = LOGO_WIDTH)

proc renderHeader*(navlinks: seq[NavLink]): VNode =
  result = buildHtml(tdiv(class = "col-1", id = "header")):
    header(class = "grid-column"):
      logo()
      navlinkbar(navlinks)
