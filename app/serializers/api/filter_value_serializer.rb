class Api::FilterValueSerializer < ApiSerializer
  attributes :id, :value

  def value
    object.filter_group.filter_type == "digit" ? object.number_value : object.name
  end
end
