require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "first name validation" do
  	user  = users(:one)
  	user.first_name = nil
  	assert_not user.valid?
  end

  test "last name validation" do
  	user  = users(:one)
  	user.last_name = nil
  	assert_not user.valid?
  end
  test "email validation" do
  	user = users(:one)
  	user.email = nil
  	assert_not user.valid?
  	
  end
  test "password validation" do
  	user = users(:one)
  	user.password = nil
  	assert_not user.valid?

  end
  test "valid user validation" do
  	user = users(:one)
  	user.password = "12345"
  	assert user.valid?

  end
end