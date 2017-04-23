require Rails.root.join "app/controllers/concerns/serializer_api.rb"

class ApiSerializer < ActiveModel::Serializer

  include SerializerApi 

  def attributes
    super.merge fetch_attributes(self.try(@scope.to_s).to_a)
  end

  def fetch_attributes(attributes=[])
    (attributes.map do |a| 
      [a, (self.try(a) || object.try(a))] 
    end).to_h
  end
end
