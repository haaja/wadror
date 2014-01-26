class Brewery < ActiveRecord::Base
  include RatingAverage

  validates_presence_of :name
  validates :year, presence: true,
                   numericality: { :only_integer => true}
  validate :validate_year_range

  has_many :beers
  has_many :ratings, :through => :beers

  def validate_year_range
    if not year.between?(1042, Date.today.year)
      errors.add(:year, "must be between 1042 and #{Date.today.year}")
    end
  end

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
