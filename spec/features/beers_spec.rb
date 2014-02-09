require 'spec_helper'

include OwnTestHelper

describe 'Beers' do
  let!(:user) { FactoryGirl.create :user }
  let!(:brewery) { FactoryGirl.create :brewery }

  before :each do
    sign_in(username:'Pekka', password:'Foobar1')
  end

  it 'a new beer should not be added if the data is not valid' do
    visit new_beer_path
    fill_in('beer_name', with:'')

    select('Lager', from: 'beer_style')
    select(brewery.name, from: 'beer_brewery_id')

    expect{
      click_button('Create Beer')
    }.to change{ Beer.count }.by(0)

    expect(current_path).to eq(beers_path)
    expect(page).to have_content "Name can't be blank"
  end

  it 'a new beer should be added if the data is valid' do
    visit new_beer_path
    fill_in('beer_name', with:'Example beer')

    select('Lager', from: 'beer_style')
    select(brewery.name, from: 'beer_brewery_id')

    expect{
      click_button('Create Beer')
    }.to change{ Beer.count }.by(1)
  end
end
