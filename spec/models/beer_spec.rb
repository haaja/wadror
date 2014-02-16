require 'spec_helper'

describe Beer do
  it 'has the name and style set' do
    style = Style.create name: 'Lager', description: 'Bad'
    beer = Beer.create name:'Test beer', style: style

    beer.name.should == 'Test beer'
    beer.style.should eq(style)
    expect(beer).to be_valid
    expect(Beer.count).to eq(1)
  end

  it 'is not saved without name' do
    beer = Beer.create

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end

  it 'is not created without a style' do
    beer = Beer.create name:'Best beer'

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end
end
