require 'spec_helper'

describe User do
  it 'has the username set correctly' do
    user = User.new username: 'Pekka'

    user.username.should == 'Pekka'
  end

  it 'is not saved without a password' do
    user = User.create username: 'Pekka'

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  it 'is not saved with too short password' do
    user = User.create username: 'Pekka', password: '123', password_confirmation: '123'

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  it 'is not saved with password consisting of only letters' do
    user = User.create username:'Pekka', password:'ABcdEF', password_confirmation:'ABcdEF'

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  describe 'with a proper password' do
    let(:user){ FactoryGirl.create(:user) }

    it 'is saved' do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end

    it 'and with two ratings, has the correct average rating' do
      user.ratings << FactoryGirl.create(:rating)
      user.ratings << FactoryGirl.create(:rating2)

      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end
  end

  describe 'favorite beer' do
    let(:user){ FactoryGirl.create(:user) }

    it 'has method for determining the favorite_beer' do
      user.should respond_to :favorite_beer
    end

    it 'without rating does not have a favourite beer' do
      expect(user.favorite_beer).to eq(nil)
    end

    it 'is the only rated if only one rating' do
      beer = create_beer_with_rating(10, user)

      expect(user.favorite_beer).to eq(beer)
    end

    it 'is the one with highest rating if several rated' do
      create_beer_with_ratings(10, 20, 15, 7, 9, user)
      best = create_beer_with_rating(25, user)

      expect(user.favorite_beer).to eq(best)
    end
  end

  describe 'favorite style' do
    let(:user) { FactoryGirl.create(:user) }

    it 'has method for determining favorite style' do
      user.should respond_to :favorite_style
    end

    it 'without rating does not have favorite style' do
      expect(user.favorite_style).to eq(nil)
    end

    it 'with one rating should have the beers rating as the favorite' do
      beer = create_beer_with_rating(10, user)

      expect(user.favorite_style).to eq(beer.style)
    end

    it 'with many ratings should return the style with highest average' do
      style = 'IPA'
      create_beer_with_ratings_and_style(10, 20, 15, 7, 9, 8, style, user)
      create_beer_with_ratings_and_style(1, 2, 3, 4, 5, 'Lager', user)
      expect(user.favorite_style.name).to eq(style)
    end
  end

  describe 'favorite brewery' do
    let(:user) { FactoryGirl.create(:user) }

    it 'has method for detemining favorite brewery' do
      user.should respond_to :favorite_brewery
    end

    it 'without ratings does not have a favorite brewery' do
      expect(user.favorite_brewery).to eq(nil)
    end

    it 'with one rating should return the brewery of the beer as the favorite' do
      beer = create_beer_with_rating(10, user)

      expect(user.favorite_brewery).to eq(beer.brewery)
    end

    it 'with many ratings should return the brewery with the highest average rating' do
      favorite_brewery = FactoryGirl.create(:brewery, name: 'favorite')
      default_brewery = FactoryGirl.create(:brewery)
      create_beer_with_ratings_and_brewery(1, 2, 3, 4, 5, default_brewery, user)
      create_beer_with_ratings_and_brewery(20, 22, 13, 24, 25, favorite_brewery, user)

      expect(user.favorite_brewery).to eq(favorite_brewery)
    end
  end

  # helper methods
  def create_beer_with_rating(score, user)
    beer = FactoryGirl.create(:beer)
    FactoryGirl.create(:rating, score: score, beer: beer, user: user)
    beer
  end

  def create_beer_with_ratings(*scores, user)
    scores.each do |score|
      create_beer_with_rating(score, user)
    end
  end

  def create_beer_with_rating_and_style(score, style, user)
    beer_style = FactoryGirl.create(:style, name: style, description: style)
    beer = FactoryGirl.create(:beer, style: beer_style)
    FactoryGirl.create(:rating, score: score, beer: beer, user: user)
    beer
  end

  def create_beer_with_ratings_and_style(*scores, style, user)
    scores.each do |score|
      create_beer_with_rating_and_style(score, style, user)
    end
  end

  def create_beer_with_rating_and_brewery(score, brewery, user)
    beer = FactoryGirl.create(:beer, brewery: brewery)
    FactoryGirl.create(:rating, score: score, beer: beer, user: user)
  end

  def create_beer_with_ratings_and_brewery(*scores, brewery, user)
    scores.each do |score|
      create_beer_with_rating_and_brewery(score, brewery, user)
    end
  end
end
