require 'spec_helper'

include OwnTestHelper

describe 'Rating' do
  let!(:brewery) { FactoryGirl.create :brewery, name: 'Koff' }
  let!(:beer1) { FactoryGirl.create :beer, name: 'iso 3', brewery: brewery }
  let!(:beer2) { FactoryGirl.create :beer, name: 'Karhu', brewery: brewery }
  let!(:user) { FactoryGirl.create :user }

  before :each do
    sign_in(username:'Pekka', password:'Foobar1')
  end

  it 'when given, is registered to the beer and user who is signed in' do
    visit new_rating_path
    select('iso 3', from: 'rating[beer_id]')
    fill_in('rating[score]', with: 15)

    expect{
      click_button 'Create Rating'
    }.to change{ Rating.count }.from(0).to(1)

    expect(user.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
    expect(beer1.average_rating).to eq(15.0)
  end

  describe 'on the ratings page' do
    it 'should show the number of ratings as zero when there are no ratings' do
      visit ratings_path

      expect(page).to have_content 'Number of ratings: 0'
    end

    it 'should show the number of ratings when there are ratings' do
      beer1.ratings << FactoryGirl.create(:rating)
      beer1.ratings << FactoryGirl.create(:rating)
      beer1.ratings << FactoryGirl.create(:rating)
      beer2.ratings << FactoryGirl.create(:rating2)
      beer2.ratings << FactoryGirl.create(:rating2)
      visit ratings_path

      expect(page).to have_content 'Number of ratings: 5'
    end
  end
end