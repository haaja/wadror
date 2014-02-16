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

s1 = Style.create name:"Lager", description:"Lager is a type of beer that is fermented and conditioned at low temperatures."
s2 = Style.create name:"Pale ale", description:"Pale ale is a beer made by warm fermentation using predominantly pale malt."
s3 = Style.create name:"Weizen", description:"Wheat beer is a beer that is brewed with a large proportion of wheat in addition to malted barley."
s4 = Style.create name:"Porter", description:"Porter is a dark style of beer originating in London in the 18th century, descended from brown beer, a well hopped beer made from brown malt."

b1.beers.create name:"Iso 3", style: s1
b1.beers.create name:"Karhu", style: s1
b1.beers.create name:"Tuplahumala", style: s1
b2.beers.create name:"Huvila Pale Ale", style: s2
b2.beers.create name:"X Porter", style: s4
beer3 = b3.beers.create name:"Hefezeizen", style: s3
beer4 = b3.beers.create name:"Helles", style: s1

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
