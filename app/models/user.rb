class User < ApplicationRecord
  attr_accessor :remember_token

  before_save :downcase_email

  validates :name, presence: true,
                  length: {maximum: Settings.numbers.name_max_length}
  validates :email, presence: true,
                    length: {maximum: Settings.numbers.email_max_length},
                    format: {
                      with: Regexp.new(Settings.numbers.VALID_EMAIL_REGEX, true)
                    },
                    uniqueness: true
  validates :password, length: {minimum: Settings.numbers.password_min_length},
  allow_nil: true
  has_secure_password

  class << self
    def digest string
      cost = if ActiveModel::SecurePassword.min_cost
               BCrypt::Engine::MIN_COST
             else
               BCrypt::Engine.cost
             end
      BCrypt::Password.create(string, cost:)
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated? remember_token
    return false unless remember_digest

    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  private

  def downcase_email
    self.email = email.downcase
  end
end
