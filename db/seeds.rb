# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Sample users we use to seed database
seed_users = [
	{password: "password1", email: "yoyo@gmail.com"},
	{password: "password2", email: "john@gmail.com"},
	{password: "password3", email: "miles@gmail.com"},
	{password: "password4", email: "victor@gmail.com"},
	{password: "password5", email: "calix@gmail.com"}
]

seed_users.each do |user|
	User.create!(user)
end

# Sample people we use to seed database
seed_people = [
    {username: "yoyo", firstname: "Yoyo", lastname: "Wu", telephone: "6471111111", state: "Ontario", country: "Canada", city: "Toronto", address: "80 Bloor St.", addressno:"80", user_id: "1"},
    {username: "john", firstname: "John", lastname: "Xie", telephone: "6471234567", state: "Ontario", country: "Canada", city: "Montreal", address: "901 Rue du Square-Victoria", addressno:"901", user_id: "2"},
    {username: "miles", firstname: "Miles", lastname: "Yu", telephone: "4161234567", state: "Ontario", country: "Canada", city: "Toronto", address: "222 Elm St.", addressno:"222", user_id: "3"},
    {username: "victor", firstname: "Victor", lastname: "Vallejo", telephone: "4161111111", state: "Ontario", country: "Canada", city: "Vancouver", address: "900 W Georgia St.", addressno:"900", user_id: "4"},
    {username: "calix", firstname: "Calix", lastname: "Zhang", telephone: "6479993333", state: "Ontario", country: "Canada", city: "Toronto", address: "801 Bay St.", addressno:"801", user_id: "5"}
]

seed_people.each do |person|
  Person.create!(person)
end


# Sample items we use to seed database
seed_items = [
    {name: "pencil crayons", description: "school supplies with 24 pencil crayons all working", deposit: "2", image_link: "https://i5.walmartimages.com/dfw/4ff9c6c9-12e3/k2-_b4874a79-bc1c-499e-9f6c-89b65746d90e.v1.jpg?odnWidth=282&odnHeight=282&odnBg=ffffff", is_available: true, is_deleted: false, person_id: "1"},
    {name: "26 inch mountain bike", description: "this bike is 2 years old with 21 speeds twist grip", deposit: "20", image_link: "https://images.freeimages.com/images/large-previews/e3d/mountain-bike-1450482.jpg", is_available: true, is_deleted: false, person_id: "1"},
    {name: "Harry Potter Book", description: "Harry Potter and the Cursed Child Parts One and Two.", deposit: "2.50", image_link: "https://media.gettyimages.com/photos/harry-potter-and-the-cursed-child-picture-id584496358?b=1&k=6&m=584496358&s=170x170&h=1Dt7KXm1uA5yGa3gp_P2N938Hi8KKozhsTV07JGZfPE=", is_available: true, is_deleted: false, person_id: "3"},
    {name: "16 inch bike", description: "Learning to cycle is easy with the 16 inch bike. This bike has a pink and purple frame.", deposit: "2", image_link: "https://image.smythstoys.com/original/desktop/118081.jpg", is_available: true, is_deleted: false, person_id: "1"},
    {name: "folding bike", description: "A folding bike for use around the neighbourhood", deposit: "35", image_link: "https://d3k6qlxswbk0wh.cloudfront.net/wp-content/uploads/2016/12/51.jpg", is_available: true, is_deleted: false, person_id: "1"},
    {name: "fountain pen", description: "office supplies. shiny black fountain pen", deposit: "6", image_link: "https://images.freeimages.com/images/large-previews/310/fountain-pen-1241296.jpg", is_available: true, is_deleted: false, person_id: "1"},
    {name: "Harry Potter", description: "Harry Potter book #5", deposit: "3", image_link: "https://images.freeimages.com/images/small-previews/8de/harry-potter-book-5-1458017.jpg", is_available: true, is_deleted: false, person_id: "2"},
    {name: "Come with me", description: "one of my favourite books.", deposit: "2.50", image_link: "https://img1.od-cdn.com/ImageType-100/0293-1/%7BDFF891E0-9A63-4D59-BFCF-C25D9ABA9C52%7DImg100.jpg", is_available: true, is_deleted: false, person_id: "2"},
    {name: "Taking the work out of networking", description: "A book written of a former Google executive", deposit: "2", image_link: "https://img1.od-cdn.com/ImageType-100/0439-1/%7B95F07495-DDAD-4E33-9A52-3647F3B3C284%7DImg100.jpg", is_available: true, is_deleted: false, person_id: "2"},
    {name: "Elephants", description: "A book about elephants for kids", deposit: "2", image_link: "https://img1.od-cdn.com/ImageType-100/0293-1/%7BA1F953F1-6322-4073-9689-F0B0DF244124%7DImg100.jpg", is_available: true, is_deleted: false, person_id: "3"},
    {name: "pencil crayons", description: "school supplies with 24 pencil crayons all working", deposit: "2", image_link: "https://i5.walmartimages.com/dfw/4ff9c6c9-12e3/k2-_b4874a79-bc1c-499e-9f6c-89b65746d90e.v1.jpg?odnWidth=282&odnHeight=282&odnBg=ffffff", is_available: true, is_deleted: false, person_id: "1"},
    {name: "Mountain bike", description: "this bike is 5 years old with 21 speeds twist grip", deposit: "24", image_link: "https://images.freeimages.com/images/large-previews/e3d/mountain-bike-1450482.jpg", is_available: true, is_deleted: false, person_id: "4"},
    {name: "Harry Potter", description: "Harry Potter and the Cursed Child Parts One and Two", deposit: "2.50", image_link: "https://media.gettyimages.com/photos/harry-potter-and-the-cursed-child-picture-id584496358?b=1&k=6&m=584496358&s=170x170&h=1Dt7KXm1uA5yGa3gp_P2N938Hi8KKozhsTV07JGZfPE=", is_available: true, is_deleted: false, person_id: "2"},
    {name: "bike", description: "this 16 inch bike is perfect for little girls", deposit: "2", image_link: "https://image.smythstoys.com/original/desktop/118081.jpg", is_available: true, is_deleted: false, person_id: "3"},
    {name: "folding bike", description: "A folding bike to be easily folded when storing", deposit: "47", image_link: "https://d3k6qlxswbk0wh.cloudfront.net/wp-content/uploads/2016/12/51.jpg", is_available: true, is_deleted: false, person_id: "5"},
    {name: "black fountain pen", description: "office supplies", deposit: "3", image_link: "https://images.freeimages.com/images/large-previews/310/fountain-pen-1241296.jpg", is_available: true, is_deleted: false, person_id: "5"},
    {name: "Harry Potter #5", description: "Harry Potter book #5", deposit: "2", image_link: "https://images.freeimages.com/images/small-previews/8de/harry-potter-book-5-1458017.jpg", is_available: true, is_deleted: false, person_id: "3"},
    {name: "My all-time favourite", description: "Come with me", deposit: "5.6", image_link: "https://img1.od-cdn.com/ImageType-100/0293-1/%7BDFF891E0-9A63-4D59-BFCF-C25D9ABA9C52%7DImg100.jpg", is_available: true, is_deleted: false, person_id: "1"},
    {name: "Taking the work out of networking", description: "a book for everyone", deposit: "2.4", image_link: "https://img1.od-cdn.com/ImageType-100/0439-1/%7B95F07495-DDAD-4E33-9A52-3647F3B3C284%7DImg100.jpg", is_available: true, is_deleted: false, person_id: "4"},
    {name: "Elephants book", description: "A book to learn all about elephants", deposit: "2", image_link: "https://img1.od-cdn.com/ImageType-100/0293-1/%7BA1F953F1-6322-4073-9689-F0B0DF244124%7DImg100.jpg", is_available: true, is_deleted: false, person_id: "5"}
]

seed_items.each do |item|
  Item.create!(item)
end
