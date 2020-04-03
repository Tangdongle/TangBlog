import norm

import wapphpkg/models


withDb:
  try:
    discard Page.getOne("slug = 'home'")
  except KeyError:
    echo "Creating home page"
    var page = Page(
      title: "Home Page",
      slug: "home",
      content: "Home Page!"
    )
    page.insert()

  var sca = SiteConfig.getAll()
  var sco = sca[0]
  sco.delete()
  var sc = SiteConfig(
    name: "base",
    baseUrl: "http://0.0.0.0:5000"
  )
  sc.insert()

