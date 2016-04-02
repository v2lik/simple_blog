class User < ActiveRecord::Base
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_secure_password

  validates :login, presence: true, uniqueness: true
  validates :password, length: { minimum: 6 }
end
