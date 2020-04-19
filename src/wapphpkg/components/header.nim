include karax/prelude
import navlinkbar

const LOGOPATH = "logo.png"

var links: seq[tuple[slug: cstring, title: cstring]] = @[("home".cstring, "Home Page".cstring), ("Test".cstring, "Test Post".cstring)]

proc logo(): VNode =
  result = buildHtml(tdiv(class = "col-2")):
    img(src = LOGOPATH, alt = "Tongirs Stuff")

proc renderHeader*(): VNode =
  result = buildHtml(tdiv(class = "col-2")):
    tdiv(class = "grid-8"):
      logo()
      navlinkbar(links)
