# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(name: "example",
            email: "admin@example.com",
            password: "password",
            password_confirmation: "password",
            admin: true).create_account_activation(activated: true)

99.times do |n|
  User.create(name: "example#{n}",
              email: "example#{n}@example.com",
              password: "password",
              password_confirmation: "password").create_account_activation(activated: true)
end
