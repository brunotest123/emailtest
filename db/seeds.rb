# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

r = Restaurant.create name: 'Dublin', email: 'bruno@dublin.com', country_code: 'ie', phone_number: '89 976 3250'
Guest.create name: 'Bruno Diniz', email: 'bruno@diniz.com'

Shift.create restaurant: r, name: 'morning', start_at: '09:00', end_at: '13:30'
Shift.create restaurant: r, name: 'dinning', start_at: '17:00', end_at: '22:30'

(1..5).each do |i|
  Table.create restaurant: r, name: "Table: #{i.to_s}", minimun_guest: 1, maximun_guest: 5
end