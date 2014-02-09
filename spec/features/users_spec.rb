require 'spec_helper'

include OwnTestHelper

describe 'User' do
  let!(:user) { FactoryGirl.create :user }

  describe 'who was signed up' do
    it 'can signin with right credentials' do
      sign_in(username:'Pekka', password:'Foobar1')

      expect(page).to have_content 'Welcome back!'
      expect(page).to have_content 'Pekka'
    end

    it 'is redirected back to signin from if wrong credentials are given' do
      sign_in(user:'Pekka', password:'WillNotWork')

      expect(current_path).to eq(signin_path)
      expect(page).to have_content 'username and password do not match'
    end

    it 'when signed up with good credentials, is added to the system' do
      visit signup_path
      fill_in('user_username', with: 'Brian')
      fill_in('user_password', with: 'Secret55')
      fill_in('user_password_confirmation', with: 'Secret55')

      expect {
        click_button('Create User')
      }.to change{ User.count }.by(1)
    end
  end

  describe 'on the user page' do
    let!(:brewery) { FactoryGirl.create :brewery, name: 'Koff' }
    let!(:beer1) { FactoryGirl.create :beer, name: 'iso 3', brewery: brewery }
    let!(:beer2) { FactoryGirl.create :beer, name: 'Karhu', brewery: brewery }

    it 'no ratings are shown if there are none' do
      visit user_path(user)

      expect(page).to have_content "#{user.username}"
      expect(page).to have_content 'The user has no ratings'
    end

    it 'shows a rating when there is one' do
      user.ratings << FactoryGirl.create(:rating, beer: beer1)

      visit user_path(user)
      expect(page).to have_content 'has made 1 rating, average 10.0'
    end

    it 'only users own ratings and average is shown' do
      user.ratings << FactoryGirl.create(:rating, beer: beer1)
      user.ratings << FactoryGirl.create(:rating, beer: beer2)
      FactoryGirl.create(:rating, beer: beer2)
      FactoryGirl.create(:rating2, beer: beer2)

      visit user_path(user)
      expect(page).to have_content 'has made 2 ratings, average 10.0'
      expect(Rating.count).to eq(4)
    end

    it 'deleting a rating will remove it from the database' do
      user.ratings << FactoryGirl.create(:rating, beer: beer1)
      user.ratings << FactoryGirl.create(:rating, beer: beer2)
      FactoryGirl.create(:rating, beer: beer2)
      FactoryGirl.create(:rating2, beer: beer2)

      sign_in(username:'Pekka', password:'Foobar1')

      visit user_path(user)

      expect(Rating.count).to eq(4)
      expect{
        click_link('delete', :match => :first)
      }.to change{ user.ratings.count }.by(-1)
      expect(Rating.count).to eq(3)
    end
  end
end
