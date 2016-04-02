class Post < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  belongs_to :user

  validates :title, :body, :user, presence: true
end
