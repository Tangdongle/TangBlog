import os
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

    PageAside* {.dbtable: "asides".} = object
      pageId* {.
        dbType: "INTEGER",
        fk: Page.id
        .}: int
      title*: string
      content*: string

    Image* {.dbtable: "images".} = object
      name* {.unique.}: string
      filename* {.unique.}: string

    PageAsideImage* {.dbTable: "asideimage".} = object
      aside* {.
        fk: PageAside.id,
        dbCol: "asideid",
        dbType: "INTEGER",
      .}: int
      image* {.
        fk: Image.id,
        dbCol: "imageid",
        dbType: "INTEGER",
      .}: int

    SiteConfig* = object
      name* {.unique.}: string
      baseUrl*: string

