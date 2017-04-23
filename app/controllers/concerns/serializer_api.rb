module SerializerApi
  extend ActiveSupport::Concern
  def serialize_objects(objects, serializer, options = {})
    options = options.merge({ each_serializer: serializer })
    ActiveModel::ArraySerializer.new(objects, options)
  end

  def serialize_object(object, serializer = nil, options= {})
    serializer ||= [object.class.name, 'Serializer'].join().constantize
    serializer.new(object, scope: options[:scope]).as_json(options.merge(root: false))
  end
end
