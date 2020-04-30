when defined(js):
  include karax/prelude
  import karax/kdom

  proc navlinkbar*(links: seq[tuple[slug: cstring, title: cstring]]): VNode =
    result = buildHtml(tdiv(className="col-4 nav")):
      nav:
        ul:
          for link in links:
            li:
              a(href = link.slug):
                text link.title
