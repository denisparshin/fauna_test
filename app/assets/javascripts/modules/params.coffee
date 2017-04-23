@module "App.Params", ->

  assign = (obj, keyPath, value) ->
    lastKeyIndex = keyPath.length - 1
    i = 0
    while i < lastKeyIndex
      key = keyPath[i]
      if !(key of obj)
        obj[key] = {}
      obj = obj[key]
      ++i
    obj[keyPath[lastKeyIndex]] = value
    return value

  @get = (string = location.href.replace(/^[^\?]+\?(.+)$/, '$1')) ->
    buf = {}
    keys = _.map(string.split('&'), (i) ->
      decodeURIComponent(i).replace /[\]]/g, ''
    )
    _.each(keys, (k) ->
      data = k.split("=")
      assign(buf, data[0].split("["), data[1])
    )
    buf
