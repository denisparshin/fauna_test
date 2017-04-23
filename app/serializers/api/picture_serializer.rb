class Api::PictureSerializer < ApiSerializer
  attributes :id, :url

  def url 
    # TODO fix this kostyl'
    object.file.url if object.file
  end
end
