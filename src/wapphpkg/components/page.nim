include karax/prelude
import header, asidebar

type
  Page = ref object
    id: int
    title: kstring
    content: kstring

proc render(): VNode =
  result = buildHtml(tdiv(class = "main")):
    tdiv(class = "grid-equalHeight", id = "main-content"):
      renderHeader()
      tdiv(class = "col-8", id = "content"):
        h2:
          text "Tanger's Stuff"
        article:
          text "Test Content"
      renderAside()
    tdiv(class = "grid-center", id = "footer"):
      footer(class = "col-7"):
        text "Test Footer"

setRenderer(render)
