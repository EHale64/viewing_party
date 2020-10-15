# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(email: 'elon@musk.com', password: '1234')
User.create!(email: 'nikola@tesla.com', password: '1234')
User.create!(email: 'thomas@edison.com', password: '1234')

Party.create!(title: "Rush Hour", duration: 220, date: '12/20/20', time: '4:00')

UserParty.create!(party_id: @party2.id, attendee_id: @user.id)
