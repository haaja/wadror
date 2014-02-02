# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
b1 = Brewery.create name:"Koff", year:1897
b2 = Brewery.create name:"Malmgard", year:2001
b3 = Brewery.create name:"Weihenstephaner", year:1042

b1.beers.create name:"Iso 3", style:"Lager"
b1.beers.create name:"Karhu", style:"Lager"
b1.beers.create name:"Tuplahumala", style:"Lager"
b2.beers.create name:"Huvila Pale Ale", style:"Pale Ale"
b2.beers.create name:"X Porter", style:"Porter"
beer3 = b3.beers.create name:"Hefezeizen", style:"Weizen"
beer4 = b3.beers.create name:"Helles", style:"Lager"

u1 = User.create username:"Test", password:"SalaK4l4", password_confirmation:"SalaK4l4"
u2 = User.create username:"TestTest", password:"SalaK4l4SalaK4l4", password_confirmation:"SalaK4l4SalaK4l4"

u1.ratings.create beer:beer3, score:20
u1.ratings.create beer:beer4, score:25
u2.ratings.create beer:beer4, score:10

c1 = BeerClub.create name:"Vallilan hiiva", founded:1989, city:"Helsinki"
c2 = BeerClub.create name:"Kumpulan akateeminen olutseura", founded:2011, city:"Helsinki"

u1.beer_clubs << c1
u1.beer_clubs << c2
u2.beer_clubs << c1
