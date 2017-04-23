class FilterGroup < ActiveRecord::Base
  has_many :filter_values, dependent: :destroy
  enum filter_type: {
    text: 0,
    digit: 1
  }
  scope :index, -> { includes(:filter_values) }
end
