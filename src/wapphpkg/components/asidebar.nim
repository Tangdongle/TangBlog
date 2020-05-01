when defined(js):
  include karax/prelude
  import karax/kdom
  import karax/kajax
  import options
  import models
  import os

  const
    HIDDEN: cstring = "<<"
    OPEN: cstring = ">>"

  type
    AsideState = ref object
      hidden: bool
      aside: Aside
      loaded: bool

  proc newAside(): AsideState =
    new result
    result.hidden = true
    result.aside = Aside()
    result.loaded = false

  var asideState = newAside()

  proc fetchAside(httpStatus: int, response: cstring) =
    ## Fetch an Aside object from the database
    let aside = fromJson[Aside](response)
    asideState.aside = aside
    asideState.loaded = true

  proc asideToggleAction(slug: cstring): proc() =
    ## When we hit the show/hide button, we want to load content
    result = proc() =
      asideState.hidden = not asideState.hidden
      if not asideState.loaded:
        ajaxGet("/aside" / "for_page_slug" / $slug, @[], fetchAside)

  proc renderAside*(slug: cstring = ""): VNode =
    ## Render a page Aside
    let isHidden = asideState.hidden
    let hiddentext: cstring = if isHidden: "" else: " open"

    result = buildHtml(tdiv(class = "col-3" & hiddenText, id = "side")):
      aside(class = "grid-column-noGutter grid-right" & hiddenText):
        tdiv(class = "col"):
          button(onclick = asideToggleAction(slug)):
            text if isHidden: HIDDEN else: OPEN
        if not isHidden:
          if not asidestate.loaded:
            h3:
              text "Loading"
          else:
            h3:
              text asideState.aside.title
            tdiv(class = "col"):
              if asideState.aside.content.len > 0:
                tdiv(class = "aside-content"):
                  p:
                    text asideState.aside.content
              if asideState.aside.images.len > 0:
                for im in asideState.aside.images:
                  img(src = "/" & im.filename, alt = im.name)
