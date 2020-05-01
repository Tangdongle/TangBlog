import norm, strformat
import norm/postgres

import wapphpkg/models

const TEST_IMAGE_PATH = "img/pylogo.png"

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

  let page = Page.getOne("slug = 'home'")
  try:
    discard PageAside.getOne(fmt"pageId = {page.id}")
  except KeyError:
    echo "Creating Aside"
    var aside = PageAside(
      pageId: page.id,
      title: "Welcome to the home page",
      content: "Check out these mad images"
    )
    aside.insert()

  try:
    discard Image.getOne("name = 'pylogo.png'")
  except KeyError:
    var image = Image(
      name: "pylogo.png",
      filename: TEST_IMAGE_PATH
    )
    image.insert()

  let fkAside = PageAside.getOne("pageId = '" & $page.id & "'")
  let fkImage = Image.getOne("name = 'pylogo.png'")
  try:
    discard PageAsideImage.getOne(fmt"asideid = {fkAside.id} and imageid = {fkImage.id}")
  except KeyError:
    var pai = PageAsideImage(
      aside: fkAside.id,
      image: fkImage.id
    )
    pai.insert()
