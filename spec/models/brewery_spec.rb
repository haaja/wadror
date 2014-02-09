require 'spec_helper'

BeerClub
BeerClubsController

describe Brewery do
  it 'has the name and year set correctly and is saved to database' do
    brewery = Brewery.create name:'Schlenkerla', year:1674

    brewery.name.should == 'Schlenkerla'
    brewery.year.should == 1674
    brewery.should be_valid

    expect(brewery.name).to eq('Schlenkerla')
    expect(brewery.year).to eq(1674)
    expect(brewery).to be_valid
  end

  it 'without a name is not valid' do
    brewery = Brewery.create  year:1674

    expect(brewery).not_to be_valid
  end

  # same test but using newer syntax
  describe 'when initialized with name Schlenkerla and year 1674' do
    subject{ Brewery.create name: 'Schlenkerla', year: 1674 }

    it { should be_valid }
    its(:name) { should eq('Schlenkerla') }
    its(:year) { should eq(1674) }
  end
end
