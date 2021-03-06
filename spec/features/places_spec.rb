require 'spec_helper'

describe 'Places' do
  it 'if one is returned by the API, it is shown at the page' do
    BeermappingApi.stub(:places_in).with('kumpula').and_return(
        [ Place.new(:name => 'Oljenkorsi', :id => 1) ]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button 'Search'

    expect(page).to have_content 'Oljenkorsi'
  end

  it 'if multiple results is returned by the API, they are all shown on the page' do
    BeermappingApi.stub(:places_in).with('kumpula').and_return(
        [
            Place.new(:name => 'Oljenkorsi', :id => 1),
            Place.new(:name => 'Laskuvarjo', :id => 2),
            Place.new(:name => 'Onnenpekka', :id => 3)
        ]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button 'Search'

    expect(page).to have_content 'Oljenkorsi'
    expect(page).to have_content 'Laskuvarjo'
    expect(page).to have_content 'Onnenpekka'
  end

  it 'if the API returns no results then error message is shown on the page' do
    BeermappingApi.stub(:places_in).with('kumpula').and_return(
        [ ]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button 'Search'

    expect(page).to have_content 'No locations in kumpula'
  end
end
