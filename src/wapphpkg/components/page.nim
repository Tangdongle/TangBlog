include karax/prelude
import header

type
  Page = ref object
    id: int
    title: kstring
    content: kstring

proc render(): VNode =
  result = buildHtml(tdiv(class = "grid-5")):
    renderHeader()
    tdiv(class = "col-3"):
      h2:
        text "Tanger's Stuff"
      article:
        text "Test Content"
      footer:
        text "Test Footer"
    tdiv(class = "col-2")

setRenderer(render)
