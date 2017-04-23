class Api::FilterGroupSerializer < ApiSerializer
  attributes :id, :name, :filter_type

  def filter_values
    serialize_objects object.filter_values, Api::FilterValueSerializer, {scope: :in_filter_groups}
  end

  def index
    [:filter_values]
  end
end
