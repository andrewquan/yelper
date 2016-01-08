# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

andrew = User.create(email: "andrew@example.com", password: 'password', full_name: "Andrew Quan")

chipotle = Business.create(name: "Chipotle", description: "Mexican food.", image_url: '/tmp/chipotle.jpg')
starbucks = Business.create(name: "Starbucks", description: "Coffee chain.", image_url: '/tmp/starbucks.jpg')
panda_express = Business.create(name: "Panda Express", description: "Chinese food.", image_url: '/tmp/panda_express.jpg')