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

    styles = ratings.map{ |r| r.beer.style }.uniq
    averages = count_averages(styles)
    averages.key(averages.values.max)
  end

  def favorite_brewery
    return nil if ratings.empty?
    breweries = ratings.map{ |r| r.beer.brewery }.uniq
    averages = count_brewery_averages(breweries)
    averages.key(averages.values.max)
  end

  def count_averages(styles)
    averages = {}
    styles.each do |s|
      amount = ratings.select{ |r| r.beer.style == s }.count
      averages[s] = ratings.select{ |r|
        r.beer.style == s
      }.inject(0.0){ |sum, r| sum + r.score} / amount
    end

    averages
  end

  def count_brewery_averages(breweries)
    averages = {}
    breweries.each do |s|
      amount = ratings.select{ |r| r.beer.brewery == s }.count
      averages[s] = ratings.select{ |r|
        r.beer.brewery == s
      }.inject(0.0){ |sum, r| sum + r.score} / amount
    end

    averages
  end
end
