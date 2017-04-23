@module "App.FileSaver", ->
  @saveBlob = (blob, fileName) ->
    a = document.createElement("a")
    document.body.appendChild(a);
    a.style = "display: none"
    url = window.URL.createObjectURL(blob)
    a.href = url
    a.download = fileName
    a.click()
    window.URL.revokeObjectURL(url)

