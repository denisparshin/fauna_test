class Api::TopSliderSerializer < ApiSerializer
  attributes :id, :name, :url

  def url
    object.file.url if object.file
  end
end
