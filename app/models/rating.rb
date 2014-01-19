class Rating < ActiveRecord::Base
  belongs_to :beer

  def to_s
    beer = Beer.find_by id:beer_id
    return beer.name + ' ' + "#{score}"
  end

end
