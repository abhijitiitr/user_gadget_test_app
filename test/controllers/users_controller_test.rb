require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  def setup
    user = users(:two)
  end

  def teardown
    user = nil
  end

  test "should login a valid user" do
    session[:user_id] = users(:two).id
    get :new
    assert_redirected_to user_path(users(:two))
  end

  test "should not login an invalid user" do
    session[:user_id] = nil
    get :new
    assert_response :success
  end

  test "should create a user" do
    user_params = {
      first_name: "Jess",
      last_name: "Ryder",
      email: "jess@gmail.com",
      password: "1234"
    }
    post :create , {user: user_params}
    assert_redirected_to user_path(User.last.id)
  end

  test "should not create a user" do
    user_params = {
      first_name: "Jess",
      last_name: "Ryder",
      email: "jess@gmail.com",
      password: "123"
    }
    post :create , {user: user_params}
    assert_redirected_to new_user_path
  end

  test "should show a user" do
    session[:user_id] = users(:two).id
    get :show , id: users(:two).id
    assert_response :success
  end

  test "should redirect to login" do
    session[:user_id] = nil
    get :show , id: users(:two).id
    assert_redirected_to signin_path
  end

end
