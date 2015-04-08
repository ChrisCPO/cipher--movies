class User < ActiveRecord::Base

  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :password, length: { minimum: 6 }, allow_nil: true

  has_many :watch_lists
  has_many :movies, through: :watch_lists
  has_many :notifications

  def add_movie(movie)
    self.movies << movie
  end

  def has_movie?(movie)
    self.movies.exists?(id: movie.id)
  end

  def add_notification(new_notification)
    self.notifications << new_notification
  end

  def remove_notification(notification)
    notifications.destroy(notification)
  end

  def authenticate(password)
    return false unless user = super(password)
    user.create_token! if user.auth_token.nil?
    user
  end

  def authenticate_with_token(token)
    return false if token.nil?
    self.auth_token == token ? self : false
  end

  def create_token!
    token = SecureRandom.urlsafe_base64(nil, false)
    update_attribute :auth_token, token
  end

  def destroy_token!
    update_attribute :auth_token, nil
  end
end
