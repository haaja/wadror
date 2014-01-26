class Beer < ActiveRecord::Base
  include RatingAverage

  validates_presence_of :name

  belongs_to :brewery
  has_many :ratings, :dependent => :destroy

  def to_s
    return "#{name}, #{brewery.name}"
  end
end

