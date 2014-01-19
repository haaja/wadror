class Beer < ActiveRecord::Base
  belongs_to :brewery
  has_many :ratings, :dependent => :destroy

  def average_rating
    # this is simpler but the assignment required using inject
    #ratings.average(:score)
    ratings.inject(0.0) { |sum, rating | sum + rating.score } / ratings.count
  end

  def to_s
    return "#{name}, #{brewery.name}"
  end
end

