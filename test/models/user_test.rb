require 'test_helper'

class UserTest < ActiveSupport::TestCase

	test "simple admin save" do
		user = User.new
		user.name = "User1"
		user.email = "user1@sp.com"
		user.password = "password"
		user.password_confirmation = "password"
		user.utype = "admin"
		assert user.save
	end

	test "simple instructor save" do
		user = User.new
		user.name = "User1"
		user.email = "user1@sp.com"
		user.password = "password"
		user.password_confirmation = "password"
		user.utype = "admin"
		assert user.save
	end

	test "simple student save" do
		user = User.new
		user.name = "User1"
		user.email = "user1@sp.com"
		user.password = "password"
		user.password_confirmation = "password"
		user.utype = "admin"
		assert user.save
	end

	test "do not save without name" do
		user = User.new
		user.email = "user1@sp.com"
		user.password = "password"
		user.password_confirmation = "password"
		user.utype = "admin"
		assert_not user.save
	end

	test "do not save without email" do
		user = User.new
		user.name = "User1"
		user.password = "password"
		user.password_confirmation = "password"
		user.utype = "admin"
		assert_not user.save
	end

	test "do not save without password" do
		user = User.new
		user.name = "User1"
		user.email = "user1@sp.com"
		user.password = ""
		user.password_confirmation = ""
		user.utype = "admin"
		assert_not user.save
	end

	test "do not save with different password and password_confirmation" do
		user = User.new
		user.name = "User1"
		user.email = "user1@sp.com"
		user.password = "password"
		user.password_confirmation = "password1234"
		user.utype = "admin"
		assert_not user.save
	end

	test "do not save with too long name" do
		user = User.new
		user.name = "User1User1User1User1User1User1User1User1User1User1User1User1User1User1User1User1User1User1User1User1"
		user.email = "user1@sp.com"
		user.password = "password"
		user.password_confirmation = "password"
		user.utype = "admin"
		assert_not user.save
	end

	test "do not save with short password" do
		user = User.new
		user.name = "User1"
		user.email = "user1@sp.com"
		user.password = "pass"
		user.password_confirmation = "pass"
		user.utype = "admin"
		assert_not user.save
	end

	test "do not save with invalid utype" do
		user = User.new
		user.name = "User1"
		user.email = "user1@sp.com"
		user.password = "password"
		user.password_confirmation = "password1234"
		user.utype = "admin123"
		assert_not user.save
	end

	test "do not save with long email" do
		user = User.new
		user.name = "User1"
		user.email = "User1User1User1User1User1User1User1User1User1User1User1User1User1User1User1User1User1User1User1User1User1User1User1User1User1User1User1User1User1User1User1User1User1User1User1User1User1User1User1User1User1User1User1User1User1User1User1User1User1User1User1User1User1User1User1User1User1User1User1User1User1User1User1User1User1User1User1User1User1User1User1User1User1User1User1User1User1User1User1User1@sp.com"
		user.password = "password"
		user.password_confirmation = "password1234"
		user.utype = "admin"
		assert_not user.save
	end

	test "do not save with invalid email" do
		user = User.new
		user.name = "User1"
		user.email = "user1@spcom"
		user.password = "password"
		user.password_confirmation = "password1234"
		user.utype = "admin"
		assert_not user.save
	end	

	test "do not save duplicate email accounts" do
		user = User.new
		user.name = "User1"
		user.email = "user1@sp.com"
		user.password = "password"
		user.password_confirmation = "password"
		user.utype = "admin"
		assert user.save

		user = User.new
		user.name = "User2"
		user.email = "user1@sp.com"
		user.password = "password"
		user.password_confirmation = "password"
		user.utype = "admin"
		assert_not user.save
	end

end

