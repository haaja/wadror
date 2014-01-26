class BeerClub < ActiveRecord::Base
  has_many :members, through: :memberships, source: :user
end
