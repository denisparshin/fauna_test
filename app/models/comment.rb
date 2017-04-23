class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic: true
  has_many :comments
  belongs_to :comment
  after_save :check_parent
  belongs_to :user
end
