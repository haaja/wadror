class User < ActiveRecord::Base
  include RatingAverage
  has_many :ratings

  def to_s
    return "#{username}"
  end
end
