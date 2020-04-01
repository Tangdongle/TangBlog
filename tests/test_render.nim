import unittest
import norm
import options

import wapphpkg/render

test "correct welcome":
  withDb:
    createTables(force=true)

    let page = Page(title: "Test", slug: "Test", author: none int, content: "Test Content", parentPageId: none int)
    let id = page.insertId()

    let output = id.render()
    echo output
