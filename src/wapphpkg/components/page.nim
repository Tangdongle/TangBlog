include karax/prelude
import karax/[kdom, kajax]
import header, asidebar, models

type PageState = ref object
  currentSlug: cstring
  currentPage: Page
  navLinks: seq[NavLink]
  loaded: bool

proc newPageState(): PageState =
  new result
  result.currentSlug = ""
  result.currentPage = Page()
  result.navLinks = @[]
  result.loaded = false

var state = newPageState()

proc fetchPages(httpStatus: int, response: cstring) =
  var pages = fromJson[seq[Page]](response)
  var navLinks: seq[NavLink]
  for p in pages:
    navLinks.add(NavLink(name: p.title, url: p.slug))
    if p.slug == state.currentSlug:
      state.currentPage = p

  state.navLinks = navLinks
  state.loaded = true

proc render(): VNode =
  let
    path = window.location.pathname

  state.currentSlug = path.split("/")[^1]

  if not state.loaded:
    ajaxPost("/pages", @[], "", fetchPages)

  result = buildHtml(tdiv(class = "main")):
    tdiv(class = "grid-equalHeight", id = "main-content"):
      renderHeader(state.navLinks)
      tdiv(class = "col-8", id = "content"):
        if state.loaded:
          h2:
            text state.currentPage.title
          article:
            p:
              text state.currentPage.content
      if state.loaded:
        renderAside(state.currentPage.id)
    tdiv(class = "grid-center", id = "footer"):
      footer(class = "col-7"):
        text "Test Footer"

setRenderer(render)
