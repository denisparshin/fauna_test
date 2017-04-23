directive = ->
  restrict: "A"
  scope: false
  link: (scope, element, attrs) ->

    to_json = (workbook, result={}) ->
      workbook.SheetNames.forEach (sheetName) ->
        roa = XLSX.utils.sheet_to_row_object_array(workbook.Sheets[sheetName])
        result[sheetName] = roa if roa.length > 0
      result

    element.on "change", (e) ->
      scope.processing = true
      scope.$apply() unless scope.$$phase
      objectKey = $(e.target).attr("name")

      if e.target.files.length
        reader = new FileReader
        reader.readAsBinaryString e.target.files[0]

        reader.onload = (e) ->
          data = e.target.result
          workbook = XLSX.read(data, type: 'binary')
          json = to_json(workbook)
          scope.result[objectKey] = json[_.keys(json)[0]]
          scope.activePreview = _.take(scope.result[objectKey], 3)
          scope.activeKey = objectKey
          scope.$apply() unless scope.$$phase
          scope.processing = false
          scope.previewPopup.show()
      else
        scope.result[objectKey] = null


angular.module "app.import"
  .directive "importXlsx", [directive]
