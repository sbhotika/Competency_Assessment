require 'test_helper'

class SessionsControllerTest < ActionController::TestCase

  # Create users
  setup do
    create_users
  end

  teardown do
    remove_users
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  # Test creating new session (a.k.a logging in)
  test "should get create session" do
    post :create, {username:"admin", password:"password"}
    assert_redirected_to root_path
  end

  test "should fail to create session" do
    post :create, {username:"admin", password:"notthepassword"}
    assert_redirected_to login_path
  end

  # Test deleting session (a.k.a logging out)
  test "should get destroy session" do
    get :destroy
    assert_redirected_to login_path
  end

end
