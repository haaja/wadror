class Brewery < ActiveRecord::Base
  has_many :beers
  has_many :ratings, :through => :beers

  def to_s
    return "#{name}"
  end

  def average_rating
    # this is simpler but the assignment required using inject
    #ratings.average(:score)
    ratings.inject(0.0) { |sum, rating | sum + rating.score } / ratings.count
  end
end
