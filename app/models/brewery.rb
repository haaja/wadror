class Brewery < ActiveRecord::Base
  has_many :beers, :dependent => :destroy

  def to_s
    return "#{name}"
  end
end
