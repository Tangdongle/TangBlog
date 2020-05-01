when defined(js):
  include karax/prelude
  import karax/kdom
  import options

  const
    HIDDEN: cstring = "<<"
    OPEN: cstring = ">>"

  type AsideSection = ref object
    content: cstring
    image: cstring
    title: cstring
    hidden: bool

  proc newAside(): AsideSection =
    new result
    result.content = ""
    result.image = ""
    result.title = ""
    result.hidden = true

  var asideInstance = newAside()

  proc asideToggleAction(): proc() =
    result = proc() =
      asideInstance.hidden = not asideInstance.hidden

  proc renderAside*(asideId: int = -1): VNode =
    let isHidden = asideInstance.hidden
    let hiddentext: cstring = if isHidden: "" else: " open"

    result = buildHtml(tdiv(class = "col-3" & hiddenText, id = "side")):
      aside(class = "grid-column-noGutter grid-right" & hiddenText):
        tdiv(class = "col"):
          button(onclick = asideToggleAction()):
            text if isHidden: HIDDEN else: OPEN
        if not isHidden:
          tdiv(class = "col"):
            if asideInstance.content.len > 0:
              tdiv(class = "aside-content"):
                p:
                  text asideInstance.content
            if asideInstance.image.len > 0:
              img(href = asideInstance.image)

