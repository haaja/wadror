class Beer < ActiveRecord::Base
  belongs_to :brewery
  has_many :ratings

  def average_rating
    # this is simpler but the assignment required using inject
    #ratings.average(:score)
    ratings.inject(0.0) { |sum, rating | sum + rating.score } / ratings.count
  end
end

