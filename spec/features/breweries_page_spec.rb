require 'spec_helper'

describe 'Breweries page' do
  it 'shoud not have any berfore been created' do
    visit breweries_path
    expect(page).to have_content 'Listing breweries'
    expect(page).to have_content 'Number of breweries: 0'
  end

  describe 'when breweries exists' do
    before :each do
      @breweries = ['Koff', 'Karjala', 'Schlenkerla']
      year = 1986

      @breweries.each do |brewery_name|
        FactoryGirl.create(:brewery, name: brewery_name, year: year += 1)
      end

      visit breweries_path
    end

    it 'lists the existing breweries and their total number' do
      expect(page).to have_content "Number of breweries: #{@breweries.count}"

      @breweries.each do |brewery_name|
        expect(page).to have_content brewery_name
      end
    end

    it 'allows user to navigate to page of a brewery' do
      click_link 'Koff'

      expect(page).to have_content 'Koff'
      expect(page).to have_content 'Established at 1987'
    end
  end
end
