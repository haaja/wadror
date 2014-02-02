require 'spec_helper'

describe Beer do
  it "has the name and style set" do
    beer = Beer.create name:"Test beer", style:"Lager"

    expect(beer).to be_valid
    expect(Beer.count).to eq(1)
  end
end
