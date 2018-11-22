# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Sample users we use to seed database
seed_users = [
	{username: "John", password: "password1", email: "e1@gmail.com"},
	{username: "Miles", password: "password2", email: "e2@gmail.com"},
	{username: "Yoyo", password: "password3", email: "e3@gmail.com"},
	{username: "Victor", password: "password4", email: "e4@gmail.com"},
	{username: "Calix", password: "passwrod5", email: "e5@gmail.com"}
]

seed_users.each do |ptr|
	User.create!(ptr)
end

