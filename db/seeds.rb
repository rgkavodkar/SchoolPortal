# Create admins
# Create the super admin
User.create!(name: "Admin", 
	email: "admin@sp.com", 
	password: "password", 
	utype: "admin",
	password_confirmation: "password")

# Create 5 more admins
5.times do |n|
	name = Faker::Name.name
	email = "admin#{n+1}@sp.com"
	address = Faker::Address.secondary_address + ", " + Faker::Address.street_address + ", " + Faker::Address.city
	number = Faker::PhoneNumber.phone_number
	User.create!(name: name, 
		email: email, 
		utype: "admin",
		password: "password",
		password_confirmation: "password", 
		address: address, 
		ph_number: number)
end

# Create instructors

# Create 30 more instructors
30.times do |n|
	name = Faker::Name.name
	email = "ins#{n+1}@sp.com"
	address = Faker::Address.secondary_address + ", " + Faker::Address.street_address + ", " + Faker::Address.city
	number = Faker::PhoneNumber.phone_number
	User.create!(name: name, 
		email: email, 
		utype: "instructor",
		password: "password",
		password_confirmation: "password", 
		address: address, 
		ph_number: number)
end

# Create 300 more students
300.times do |n|
	name = Faker::Name.name
	email = "stu#{n+1}@sp.com"
	address = Faker::Address.secondary_address + ", " + Faker::Address.street_address + ", " + Faker::Address.city
	number = Faker::PhoneNumber.phone_number
	User.create!(name: name, 
		email: email, 
		utype: "student",
		password: "password",
		password_confirmation: "password", 
		address: address, 
		ph_number: number)
end