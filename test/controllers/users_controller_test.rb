require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  # Test index assigns variables
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
    assert_not_nil assigns(:inactive_users)
  end

  # Test new method
  test "should get new" do
    get :new
    assert_response :success
  end

  # Test Successful create user
  test "should create new user" do
    assert_difference('User.count', 1) do
      post :create, user: { username: "TestAdmin", password: "password", password_confirmation: "password" }
    end
  end

  # Test failure to create user because of password length
  test "should fail to create new user when password is too short" do
    assert_no_difference("User.count") do
      post :create, user: { username: "TestBadAdmin", password: "short", password_confirmation: "short" }
    end
  end

  # Test failure to create user because passwords don't match
  test "should fail to create new user when passwords don't match" do
    assert_no_difference("User.count") do
      post :create, user: { username: "TestBadAdmin", password: "password", password_confirmation: "password1" }
    end
  end

end
