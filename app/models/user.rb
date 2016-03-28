class User < ActiveRecord::Base
  has_many :posts
  has_many :comments

  has_secure_password

  validates :login, presence: true, uniqueness: true
  validates :password, length: { minimum: 6 }
end
