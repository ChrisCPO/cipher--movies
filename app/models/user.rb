class User < ActiveRecord::Base

  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :password, length: { minimum: 6 }, allow_nil: true

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
