class User < ApplicationRecord

    attr_accessor :remember_token
    before_save {self.email = email.downcase}

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    VALID_USERNAME_REGEX = /\A[0-9\w_]{0,16}\z/


    has_many :items

    validates :username, 
	presence: true, length: {maximum: 16},
        format: {with: VALID_USERNAME_REGEX},
        uniqueness: true

    validates :email,
        presence: true, length: {maximum: 255},
        format: {with: VALID_EMAIL_REGEX},
        uniqueness: {case_sensitive: false}

    has_secure_password

    validates :password, 
        presence: true, length: {minimum: 6},
        allow_nil: true

    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end

    # Return a random token
    def User.new_token
        SecureRandom.urlsafe_base64
    end

    # Remember a user in the database for persistent sessions
    def remember
        self.remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(remember_token))
    end

    # Return true if given token matches digest
    def authenticated?(remember_token)
        return false if remember_digest.nil?
        BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end

    # Forget a user
    def forget
        update_attribute(:remember_digest, nil)
    end

end

