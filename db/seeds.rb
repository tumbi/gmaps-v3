# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Role.delete_all
role = Role.create({"name" => "admin"})
role = Role.create({"name" => "company"})
role = Role.create({"name" => "staff"})
role = Role.create({"name" => "contractor"})
role = Role.create({"name" => "customer"})

User.delete_all
user = User.new :email => "admin@gmaps.com", :password => 'admingmaps', :name => "Admin", :timezone => "American Samoa", :is_active => true
user.skip_confirmation!
user.save
role = Role.find_by_name("admin")
user.roles << role