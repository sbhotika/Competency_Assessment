require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should validate_presence_of(:username)
  should validate_uniqueness_of(:username)

  context "With a proper context, " do
    setup do
      create_user
    end

    teardown do
      remove_user
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
      assert_equal [@userAdmin] U
    end

  end
end
