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

  proc getPageById(id: DbValue): Page = withDb(Page.getOne int(id.i))

  type
    Image* {.dbtable: "images".} = object
      name* {.unique.}: string
      filename* {.unique.}: string

    PageAside* {.dbtable: "asides".} = object
      pageId* {.
        dbType: "INTEGER",
        fk: Page,
        parser: getPageById,
        formatIt: ?it.id
        .}: Page
      title*: string
      content*: string


  proc getPageAsideById(id: DbValue): PageAside = withDb(PageAside.getOne int(id.i))
  proc getImageById(id: DbValue): Image = withDb(Image.getOne int(id.i))

  type
    PageAsideImage* {.dbTable: "asideimage".} = object
      aside* {.
        fk: PageAside,
        dbCol: "asideid",
        dbType: "INTEGER",
        parser: getPageAsideById,
        formatIt: ?it.id
      .}: PageAside
      image* {.
        fk: Image,
        dbCol: "imageid",
        dbType: "INTEGER",
        parser: getImageById,
        formatIt: ?it.id
      .}: Image

    SiteConfig* = object
      name* {.unique.}: string
      baseUrl*: string

