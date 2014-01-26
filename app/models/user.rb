class User < ActiveRecord::Base
  include RatingAverage

  has_secure_password

  validates :username, uniqueness: true,
                       length: { minimum: 3,
                                 maximum: 15 }
  validates_length_of :password, minimum: 4
  validates_format_of :password, with: /\A.*(?=.*[A-Z])(?=.*[0-9]).*\Z/,
                                 message: "must have at least one number and capital letter"

  has_many :ratings
  has_many :beers, through: :ratings

  def to_s
    return "#{username}"
  end
end
