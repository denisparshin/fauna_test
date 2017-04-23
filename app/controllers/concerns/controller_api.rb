module ControllerApi
  extend ActiveSupport::Concern

  def permited_params
    params.require(symbol_params_one).permit(to_permit)
  end

  def serializer_name
    ("::Api::" + class_one + "Serializer").constantize
  end

  def default_attrs
    [:id, :created_at, :updated_at]
  end

  def check_permited
    loaded_class.nested_attributes_options.keys.map do |k|
      {(k.to_s + "_attributes").to_sym => k.to_s.singularize.camelize.constantize.attribute_names.map{|a| a.to_sym } - default_attrs }
    end
  end

  def to_permit
    (loaded_class.attribute_names.map{|a| a.to_sym} - (loaded_class.try(:except_attrs).to_a + default_attrs)) + check_permited()
  end

  def loaded_resource
    instance_variable_get("@" + symbol_params_one.to_s)
  end

  def loaded_resources(scope=nil)
    res = instance_variable_get("@" + symbol_params_many.to_s)
    if loaded_class.respond_to?(scope.to_s, true)
      begin
        res.send(scope)
      rescue ArgumentError
        res.send(scope, Search.new(params[:search]))
      end
    else
      res
    end
  end

  def symbol_params_one
    class_many.tableize.singularize.to_sym
  end

  def symbol_params_many
    class_many.tableize.to_sym
  end

  def loaded_class
    class_one.constantize
  end

  def class_many
    self.class.to_s.gsub(/^Api::/, '').gsub(/Controller$/, '')
  end

  def class_one
    class_many.singularize
  end

end
