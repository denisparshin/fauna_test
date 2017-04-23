class Api::SliderSerializer < ApiSerializer
  attributes :id, :primary_pic_id

  def index
    [:pictures]
  end

  def pictures
    serialize_objects object.pictures.order(created_at: :asc), Api::PictureSerializer
  end
end
