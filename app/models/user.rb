class User < ActiveRecord::Base
  before_validation :ensure_session_token
  validates :username, :password_digest, presence: true
  validates :password, length: { minimum: 1, maximum: 6, allow_nil: true }

  attr_reader :password

  has_many :subs

  has_many(
    :posts,
    foreign_key: :author_id,
    primary_key: :id,
    class_name: :Post
  )

  def self.find_by_credentials(username, password)
    user = User.find_by_username(username)
    if user && user.is_password?(password)
      user
    else
      nil
    end
  end

  def password=(input)
    @password = input
    self.password_digest = BCrypt::Password.create(input)
  end

  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64(16)
  end

  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64(16)
    self.save!
    self.session_token
  end

  def is_password?(input)
    BCrypt::Password.new(self.password_digest).is_password?(input)
  end


end
