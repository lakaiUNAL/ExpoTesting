require 'test_helper'

class UserTest < ActiveSupport::TestCase
	def setup
		@user = User.new(name: "test user", email: "test@testingmail.com")
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
			foo@bar_baz.com foo@bar+baz.com]

		invalid_addresses.each { |address|  
			@user.email = address
			assert_not @user.valid?, "#{address.inspect} should be invalid"
		}

	end

end
