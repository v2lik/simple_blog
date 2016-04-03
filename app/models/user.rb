class User < ActiveRecord::Base
  include UserAvatarUploader

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_secure_password

  validates :login, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }

  after_save :store_avatar
  before_destroy :delete_store_dir

  class << self
    def new_auth_token
      SecureRandom.urlsafe_base64
    end

    def encrypt(token)
      Digest::SHA1.hexdigest token.to_s
    end
  end
end
