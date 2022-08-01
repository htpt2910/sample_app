class User < ApplicationRecord
  before_save :downcase_email

  validates :name, presence: true,
                  length: {maximum: Settings.numbers.name_max_length}
  validates :email, presence: true,
                    length: {maximum: Settings.numbers.email_max_length},
                    format: {
                      with: Regexp.new(Settings.numbers.VALID_EMAIL_REGEX, true)
                    },
                    uniqueness: true
  validates :password, length: {minimum: Settings.numbers.password_min_length}
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
  end

  private

  def downcase_email
    self.email = email.downcase
  end
end
