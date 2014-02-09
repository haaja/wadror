class User < ActiveRecord::Base
  include RatingAverage

  has_secure_password

  validates :username, uniqueness: true,
                       length: { minimum: 3,
                                 maximum: 15 }
  validates_length_of :password, minimum: 4
  validates_format_of :password, with: /\A.*(?=.*[A-Z])(?=.*[0-9]).*\Z/,
                                 message: 'must contain at least one number and capital letter'

  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings

  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships

  def to_s
    "#{username}"
  end

  def favorite_beer
    return nil if ratings.empty?
    ratings.order(score: :desc).limit(1).first.beer
  end

  def favorite_style
    return nil if ratings.empty?
    ratings.sort_by{ |rating| rating.score }.sort_by{ |r| r.beer.style }.first.beer.style
  end

  def favorite_brewery
    return nil if ratings.empty?
    id = ratings.sort_by{ |rating| rating.score }.sort_by{ |r| r.beer.brewery_id }.first.beer.brewery_id
    Brewery.find_by(id: id)
  end
end
