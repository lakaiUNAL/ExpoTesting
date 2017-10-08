require 'test_helper'

class UserTest < ActiveSupport::TestCase
	def setup
		@user = User.new(name: "test user", email: "test@testingmail.com", 
						password: 'test123', password: 'test123')
	end

	test "should be valid" do
		assert @user.valid?
	end

	test "name shouldn't be valid" do
		@user.name = "                  "
		assert_not @user.valid?
	end

	test "email shouldn't be valid" do
		@user.email = " "
		assert_not @user.valid?
	end

	test "maximum name lenght " do
		@user.name = 'a'*60
		assert_not @user.valid?
	end

	test "maximum email lenght" do
		@user.email = 'a' * 250 + '@prueba.co'
		assert_not @user.valid?
	end

	test "should be invalid emails" do
		invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. 
		foo@bar_baz.com foo@bar+baz.com foo@bar..com]

		invalid_addresses.each { |address|  
			@user.email = address
			assert_not @user.valid?, "#{address.inspect} should be invalid"
		}

	end

	test "email addresses should be unique" do
		duplicate_user = @user.dup
		duplicate_user.email = @user.email.upcase
		@user.save
		assert_not duplicate_user.valid?
	end

	test "email addresses should be saved as lower-case" do
		mixed_case_email = "Foo@ExAMPle.CoM"
		@user.email = mixed_case_email
		@user.save
		assert_equal mixed_case_email.downcase, @user.reload.email
	end

	test "password should be present (nonblank)" do
		@user.password = @user.password_confirmation = " " * 6
		assert_not @user.valid?
	end
	
	test "password should have a minimum length" do
		@user.password = @user.password_confirmation = "a" * 5
		assert_not @user.valid?
	end
end
