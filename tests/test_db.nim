# This is just an example to get you started. You may wish to put all of your
# tests into a single file, or separate them into multiple `test1`, `test2`
# etc. files (better names are recommended, just make sure the name starts with
# the letter 't').
#
# To run these tests, simply execute `nimble test`.

import unittest
import norm
import options

import wapphpkg/models

test "correct welcome":
  withDb:
    createTables(force=true)

    var sc = SiteConfig(baseUrl: "http://0.0.0.0:5000", name: "base")
    sc.insert()

    var page = Page(
      slug: "test",
      title: "test",
      author: none int,
      content: "Test Page",
      parentPageId: none int
    )
    let pid = page.insertId()

    check Page.getOne(pid).slug == "test"


    var childPage = Page(
      slug: "test2",
      title: "test2",
      author: none int,
      content: "Test Page",
      parentPageId: some pid
    )

    let pid2 = childPage.insertId()

    check Page.getAll().len == 2
    check Page.getOne(pid2).slug == "test2"
