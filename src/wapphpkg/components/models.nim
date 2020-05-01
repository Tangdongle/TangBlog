when defined(js):
  type
    Page* = object
      id*: int
      slug*: cstring
      title*: cstring
      author*: int
      content*: cstring
      parent*: int

    Aside* = object
      content*: cstring
      images*: seq[Image]
      title*: cstring

    Image* = object
      id*: cint
      name*: cstring
      filename*: cstring

    NavLink* = object
      name*: cstring
      url*: cstring
