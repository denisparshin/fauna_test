@module "App.BtnFile", ->
  @clear = (context) ->
    $(context).parents(".btn-file").find("input").val('').trigger('change')

  @init = ->
    $(".btn-file input").on "change", (e) ->
      $parent = $(e.target).closest(".btn-file")
      $(e.target).data("placeholder", $parent.find(".placeholder").html()) unless $(e.target).data("placeholder")
      if e.target.files && e.target.files.length
        $parent.find(".placeholder").text(e.target.files[0].name)
        $parent.find(".addon").show()
      else
        $parent.find(".placeholder").html($(e.target).data("placeholder"))
        $parent.find(".addon").hide()

$(App.BtnFile.init)
