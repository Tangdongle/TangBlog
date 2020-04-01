import normanpkg/sugar

import unicode, options

importBackend()

import logging
addHandler newConsoleLogger()

models:
  type
    Author* = object
      name*: string
      email* {.unique.}: string

    Page* {.dbTable: "pages".} = object
      slug* {.unique.}: string
      title*: string
      author* {.
        fk: Author.id,
        dbCol: "authorid",
        dbType: "INTEGER"
        .}: Option[int]
      content*: string
      parentPageId* {.
        dbType: "INTEGER",
        fk: Page.id
        .}: Option[int]
