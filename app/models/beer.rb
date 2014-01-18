class Beer < ActiveRecord::Base
  belongs_to :brewery
  has_many :ratings

  def average_rating
    avg = 0.0
    ratings.each do |rating|
      avg += rating.score
    end
    return avg/ratings.count
  end
end

