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


# Add 15 past courses
15.times do |n|
	title = "Past course#{n+1}"
	description = Faker::Lorem.paragraph(sentence_count = 6)
	start = Date.new(2015, 8, 15)
	end_ = Date.new(2015, 12, 15)
	user_id = rand(7..25)
	Course.create!(title: title,
		description:description,
		start_date: start,
		end_date: end_,
		user_id: user_id,
		status: "Inactive")
end

# Add random 'past' courses for 200 students 
grades = ["A+", "A", "A-", "B+", "B", "B-", "C+", "C", "C-", "F"]
200.times do |n|
	student_id = n + 40
	num_courses_per_student = rand(1..4)
	past_courses = [*1..15].sample(num_courses_per_student)
	num_courses_per_student.times do |i|
		StudentCourse.create!(user_id: student_id,
			course_id: past_courses[i], 
			grade: grades.sample,
			status: "completed")
	end
end


# Create current courses
15.times do |n|
	title = "Current course#{n+1}"
	description = Faker::Lorem.paragraph(sentence_count = 6)
	start = Date.today
	end_ = Date.today
	user_id = rand(7..33)
	Course.create!(title: title,
		description:description,
		start_date: start,
		end_date: end_,
		user_id: user_id,
		status: "Active")
end

# Create students enrolled in current courses
200.times do |n|
	student_id = n + 40
	num_courses_per_student = rand(1..3)
	current_courses = [*16..30].sample(num_courses_per_student)
	num_courses_per_student.times do |i|
		StudentCourse.create!(user_id: student_id,
			course_id: current_courses[i], 
			grade: "F",
			status: "enrolled")
	end
end

# Create announcements for courses
15.times do |n|
	num_announcements = rand(1..5)

	num_announcements.times do |i|
		Announcement.create!(title: "Announcement #{n+1}",
		content: Faker::Lorem.paragraphs(paragraph_count = rand(1..3)).join,
		course_id: n + 16)
	end
end