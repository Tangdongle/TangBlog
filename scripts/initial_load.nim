import norm

import wapphpkg/models

withDb:
  if Page.getAll().len == 0:
    echo "Creating home page"
    var page = Page(
      title: "Home Page",
      slug: "home",
      content: "Home Page!"
    )

