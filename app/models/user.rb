class User < ActiveRecord::Base
	before_save {self.email = self.email.downcase}
	validates :name, presence: true, length: {maximum: 50}
	validates :email, presence: true, length: {maximum: 255}, uniqueness: {case_sensitive: false}, format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i}
	validates :utype, inclusion: {in: %w(admin student instructor), message: "%{value} is not a valid user"}
	has_secure_password
	validates :password, presence: true, length: {minimum: 8}
end
