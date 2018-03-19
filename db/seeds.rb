# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

pratik = Contact.create!(name: "pratik", number: 7738059924)
mom = Contact.create!(name: "mom", number: 7727484870)
dad = Contact.create!(name: "dad", number: 7507532118)
ketki = Contact.create!(name: "ketki", number: 7638059924)





90.times do 
  fake_name = Faker::Name.first_name       #=> "Kaci"
  # Required parameter: digits
  fake_number = Faker::Number.number(10) #=> "1968353479"
  Contact.create!(  name: fake_name,
                    number: fake_number)
end