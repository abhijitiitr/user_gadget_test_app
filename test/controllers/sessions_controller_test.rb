require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  def setup
  end

  def teardown
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create a session" do
    session_params = {session: {email: users(:one).email, password: "1234"}}  
    post :create , session_params
    assert_redirected_to user_path(users(:one).id)
  end

  test "should not create a session" do
    session_params = {session: {email: users(:one).email, password: "12345"}}
    post :create , session_params
    assert_redirected_to(controller: 'sessions', action: 'new')
  end

  test "should get destroy" do
    delete :destroy
    assert_redirected_to signin_url
  end

end
