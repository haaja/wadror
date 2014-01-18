class Rating < ActiveRecord::Base
  belongs_to :beer

  def to_s
    b = Beer.find_by_brewery_id beer_id
    return b.name + " " + "#{score}"
  end

end
