# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.new
user.first_name = 'Raza'
user.last_name = 'Hussain'
user.username = 'admin'
user.email = 'admin@nxb.com.pk'
user.password  = 'password'
user.admin = true
user.save
