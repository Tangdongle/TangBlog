import norm
import models

withDB:
  proc imagesForPageAside(asideId: int): seq[Image] =
    PageAsideImage.getMany(
      100,
      cond="asideid = " & $asideId & " ORDER BY imageid"
    )

