class Brewery < ActiveRecord::Base
  include RatingAverage

  validates_presence_of :name
  validates :year, presence: true,
                   numericality: { greater_than_or_equal_to: 1042,
                                   less_than_or_equal_to: 2014,
                                   only_integer: true }
  has_many :beers
  has_many :ratings, :through => :beers

  def print_report
    puts name
    puts "established at year #{year}"
    puts "number of beers #{beers.count}"
    puts "number of ratings #{ratings.count}"
  end

  def restart
    self.year = 2014
    puts "changed year to #{year}"
  end

  def to_s
    return "#{name}"
  end
end
