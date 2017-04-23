angular.module "app.import"
  .filter "format_json", -> (json) -> JSON.stringify(json, null, '\t')

