module Contexts
  module UserContexts

    # Create three users
    def create_users
      @userAdmin = FactoryGirl.create(:user)
      @user2 = FactoryGirl.create(:user, username: "user2", password: "password", active: true)
      @user3 = FactoryGirl.create(:user, username: "user3", password: "password1", password_confirmation: "password1", active: false)
    end

    # Destroy the question objects
    def remove_users
      @userAdmin.destroy
      @user2.destroy
      @user3.destroy
    end

  end
end
