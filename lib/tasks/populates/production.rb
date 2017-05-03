# For production environment only populate with super user

# Step 1: Create an Admin
users =
  [
    ["admin", "password", "password", true]
  ]

users.each do |user|
  u = User.new
  u.username = user[0]
  u.password = user[1]
  u.password_confirmation = user[2]
  u.active = user[3]
  u.save!
end
