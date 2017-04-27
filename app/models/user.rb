class User < ActiveRecord::Base
  has_secure_password

  # Validations
  validates_presence_of :username
  validates_uniqueness_of :username
  validates_presence_of :password, on: :create
  validates_presence_of :password_confirmation, on: :create
  validates_confirmation_of :password, message: "Passwords do not match"
  validates_length_of :password, minimum: 6, message: "Password too short. Must be at least 6 characters"

  # Scopes
  scope :alphabetical, -> { order("username") }
  scope :find_by_username, -> (username) { where("username = ?", username) }
  scope :active, -> { where("active=?", true ) }
  scope :inactive, -> { where("active=?", false ) }
end
