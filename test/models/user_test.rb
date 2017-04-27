require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # Test Validations
  should have_secure_password
  should validate_presence_of(:username)
  should validate_uniqueness_of(:username)

  # Scope and method tests
  context "With a proper context, " do
    setup do
      create_users
    end

    teardown do
      remove_users
    end

    should "Show users in alphabetical order" do
      assert_equal [@userAdmin, @user2, @user3], User.alphabetical.map { |e| e }
    end

    should "Show active users" do
      assert_equal [@userAdmin, @user2], User.active.alphabetical.map { |e| e }
    end

    should "Show inactive users" do
      assert_equal [@user3], User.inactive.alphabetical.map { |e| e }
    end

    should "Find by username" do
      assert_equal [@userAdmin], User.find_by_username("admin")
    end

  end
end
