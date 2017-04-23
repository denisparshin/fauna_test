@module "CRUD", ->

  params = (data) ->
    $.extend data, authenticity_token: $("meta[name=\"csrf-token\"]").attr("content")

  url = (path) ->
    if path == "users"
      "/#{path}"
    else
      "/api/#{path}"


  fail = (data) ->
    I18n.t("js.info.something_went_wrong")

  ajax = (path, method, data) ->
    {url: url(path), method: method, data: params(data)}

  @create = (path, data, success) ->
    $.ajax(ajax(path, "POST", data)).done(success).fail(fail)

  @index = (path, data, success) ->
    $.ajax(ajax(path, "GET", data)).done(success).fail(fail)

  @update = (path, id, data, success) ->
    $.ajax(ajax("#{path}/#{id}", "PATCH", data)).done(success).fail(fail)

  @remove = (path, id, success) ->
    $.ajax(ajax("#{path}/#{id}", "DELETE", "")).done(success).fail(fail)

  @show = (path, id, success) ->
    $.ajax(ajax("#{path}/#{id}", "GET", "")).done(success).fail(fail)

