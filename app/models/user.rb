class User < ApplicationRecord

	device	:database_authenticatable, :registerable,
		:recoverable, :rememberable, :trackable, :validatable

	validates :username,
		presence: true,
		:format => {:with => /\A[0-9\w_]{4,16}\z/
			message: "Usernames may only contain letters, numbers, and underscores that are 4-16 characters in length"},
		uniqueness: true

	validates :email,
		presence: true,
		:email_format => {:message => 'Email format is incorrect.'},
		uniqueness: true

end

