import norm, os, sequtils, options, strformat, json
import models

proc newImage*(path: string, name: Option[string] = none(string)): Image =
  withDB:
    let splitName = path.splitPath().tail
    result = Image(
      name: if isSome(name): name.get else: splitName,
      filename: path
    )
    result.insert()

proc newPageAsideImage*(aside: PageAside, image: Image): PageAsideImage =
  withDB:
    result = PageAsideImage(aside: aside, image: image)
    result.insert()

proc asideForPage*(page: Page): JsonNode =
  withDB:
    let pid = PageAside.getOne(fmt"pageid = {page.id}")
    let images = PageAsideImage.getMany(
      100,
      cond=fmt"asideid = {$pid.id} ORDER BY imageid"
    ).mapIt(it.image)
    result = %* {
      "title": pid.title,
      "images": images,
      "content": pid.content
    }

proc asideForPageId*(id: int): JsonNode =
  withDb:
    asideForPage(Page.getOne(id))
