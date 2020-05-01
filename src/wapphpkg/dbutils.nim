import norm, os, sequtils, options
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

proc imagesForPageAside*(asideId: int): seq[Image] =
  withDB:
    PageAsideImage.getMany(
      100,
      cond="asideid = " & $asideId & " ORDER BY imageid"
    ).mapIt(it.image)

proc imagesForPageAside*(aside: PageAside): seq[Image] =
  imagesForPageAside(aside.id)
