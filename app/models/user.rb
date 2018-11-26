class User < ApplicationRecord

    before_save {self.email = email.downcase}
	
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    VALID_USERNAME_REGEX = /\A[0-9\w_]{0,16}\z/

    #devise: database_authenticatable, :registerable,
    #	     :recoverable, :rememberable, :trackable, :validatable

    has_many :items

    validates :username,
        presence: true, length: {maximum: 16},
        :format => {:with => VALID_USERNAME_REGEX,
            message: "Usernames may only contain letters, numbers, and 
            underscores no longer than 16 characters in length"},
        uniqueness: true

    validates :email,
        presence: true, length: {maximum: 255},
        :format => {:with => VALID_EMAIL_REGEX,
            :message => 'Email format is incorrect.'},
    uniqueness: true

    has_secure_password

    validates :password, 
        presence: true, length: {minimum: 6}

    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                      BCrypt::Engine.cost
               BCrpyt::Password.create(string, cost: cost)
    end

end

