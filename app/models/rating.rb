class Rating < ActiveRecord::Base
  belongs_to :beer
  belongs_to :user

  def to_s
    beer = Beer.find_by id:beer_id
    return beer.name + ' ' + "#{score}"
  end

end
