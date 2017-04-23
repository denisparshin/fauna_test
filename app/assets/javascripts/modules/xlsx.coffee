@module "App.XLSX", ->
  s2ab = (s) ->
    buf = new ArrayBuffer(s.length)
    view = new Uint8Array(buf)
    i = 0
    while i != s.length
      view[i] = s.charCodeAt(i) & 0xFF
      ++i
    buf

  makeCell = (c, r, item) ->
    c: c
    r: r
    v: if item then ((if typeof(item) == 'number' then item else (item + '').replace(/[\s]+/g, ' '))) else ''
    t: (if typeof(item) == 'number' then 'n' else 's')

  @fromArray = (array, sheetName) ->
    wb = {SheetNames: [sheetName], Sheets: _.object([[sheetName, {}]])}

    r = 0
    while r < array.length
      c = 0
      while c < array[r].length
        cell = makeCell(c, r, array[r][c])
        reference = XLSX.utils.encode_cell(cell)
        wb.Sheets[sheetName][reference] = cell
        c++
      r++

    wb.Sheets[sheetName]['!ref'] = XLSX.utils.encode_range(
      s: {c: 0, r: 0}, e: {c: array[0].length, r: array.length}
    )

    wbout = XLSX.write(wb, {bookType: 'xlsx', bookSST: false, type: 'binary'})
    blob = new Blob([s2ab(wbout)],{type:"application/octet-stream"})
