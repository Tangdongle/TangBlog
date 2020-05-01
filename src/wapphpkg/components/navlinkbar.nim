when defined(js):
  include karax/prelude
  import karax/kdom
  import models

  proc navlinkbar*(links: seq[NavLink]): VNode =
    result = buildHtml(tdiv(className="col-4 nav")):
      nav:
        ul:
          for link in links:
            li:
              a(href = link.url):
                text link.name
