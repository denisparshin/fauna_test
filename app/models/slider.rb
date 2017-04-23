class Slider < ActiveRecord::Base
  belongs_to :sliderable, polymorphic: true
  has_many :pictures, as: :imageable
  scope :by_sliderable_type, -> (type) { where(sliderable_type: type) if type }
  scope :by_sliderable_id, -> (id) { where(sliderable_id: id) if id }
  scope :index, -> (search) { by_sliderable_type(search.sliderable_type).by_sliderable_id(search.sliderable_id) } 
end
