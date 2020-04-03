import unittest
import norm
import options

import wapphpkg/render

test "correct welcome":
  withDb:
    createTables(force=true)
    var sc = SiteConfig(baseUrl: "http://0.0.0.0:5000", name: "base")
    sc.insert()

    let page = Page(title: "Test", slug: "Test", author: none int, content: "Test Content", parentPageId: none int)
    let id = page.insertId()

    let output = id.render()
    echo output
