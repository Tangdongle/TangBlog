import norm
import wapphpkg/models
import wapphpkg/dbutils
import unittest
import options

const TEST_IMAGE = "img/pylogo$#.png"


suite "DBUtilTests":

  test "canGetManyImages":
    withDB:
      createTables(force=true)
      var page = Page(
        slug: "testy",
        title: "Test",
        author: none(int),
        content: "Test",
        parentPageId: none(int)
      )
      page.insert()
      var pageAside = PageAside(
        pageId: page.id,
        title: "Test Aside",
        content: "Test"
      )
      pageAside.insert()
      for i in 0 .. 10:
        let i = newImage(TEST_IMAGE % $i)
        discard newPageAsideImage(pageAside, i)

      for im in pageAside.imagesForPageAside():
        echo im.id
