require 'spec_helper'

describe 'BeermappingApi' do
  it 'When HTTP GET returns one entry, it is parsed and returned' do

    canned_answer = <<-END_OF_STRING
<?xml version='1.0' encoding='utf-8' ?><bmp_locations><location><id>13307</id><name>O'Connell's Irish Bar</name><status>Beer Bar</status><reviewlink>http://beermapping.com/maps/reviews/reviews.php?locid=13307</reviewlink><proxylink>http://beermapping.com/maps/proxymaps.php?locid=13307&amp;d=5</proxylink><blogmap>http://beermapping.com/maps/blogproxy.php?locid=13307&amp;d=1&amp;type=norm</blogmap><street>Rautatienkatu 24</street><city>Tampere</city><state></state><zip>33100</zip><country>Finland</country><phone>35832227032</phone><overall>0</overall><imagecount>0</imagecount></location></bmp_locations>
    END_OF_STRING

    stub_request(:get, /.*tampere|kumpula/).to_return(body: canned_answer, headers: { 'Content-Type' => 'text/xml' })

    places = BeermappingApi.places_in('tampere')

    expect(places.size).to eq(1)
    place = places.first
    expect(place.name).to eq("O'Connell's Irish Bar")
    expect(place.street).to eq('Rautatienkatu 24')
  end

  it 'when HTTP GET returns multiple entries, entries are parsed and returned' do
    canned_answer = <<-END_OF_STRING
<?xml version='1.0' encoding='utf-8' ?><bmp_locations>
<location><id>13307</id><name>O'Connell's Irish Bar</name><status>Beer Bar</status><reviewlink>http://beermapping.com/maps/reviews/reviews.php?locid=13307</reviewlink><proxylink>http://beermapping.com/maps/proxymaps.php?locid=13307&amp;d=5</proxylink><blogmap>http://beermapping.com/maps/blogproxy.php?locid=13307&amp;d=1&amp;type=norm</blogmap><street>Rautatienkatu 24</street><city>Tampere</city><state></state><zip>33100</zip><country>Finland</country><phone>35832227032</phone><overall>0</overall><imagecount>0</imagecount></location>
<location><id>13308</id><name>Heavy Corner</name><status>Beer Bar</status><reviewlink>http://beermapping.com/maps/reviews/reviews.php?locid=13308</reviewlink><proxylink>http://beermapping.com/maps/proxymaps.php?locid=13308&amp;d=5</proxylink><blogmap>http://beermapping.com/maps/blogproxy.php?locid=13308&amp;d=1&amp;type=norm</blogmap><street>Oluttie 4</street><city>Tampere</city><state></state><zip>33100</zip><country>Finland</country><phone>35832227033</phone><overall>0</overall><imagecount>0</imagecount></location>
<location><id>13309</id><name>Pub Ruusu</name><status>Beer Bar</status><reviewlink>http://beermapping.com/maps/reviews/reviews.php?locid=13309</reviewlink><proxylink>http://beermapping.com/maps/proxymaps.php?locid=13309&amp;d=5</proxylink><blogmap>http://beermapping.com/maps/blogproxy.php?locid=13309&amp;d=1&amp;type=norm</blogmap><street>Tuoppikuja 3</street><city>Tampere</city><state></state><zip>33100</zip><country>Finland</country><phone>35832227034</phone><overall>0</overall><imagecount>0</imagecount></location>
</bmp_locations>
    END_OF_STRING

    stub_request(:get, /.*tampere|kumpula/).to_return(body: canned_answer, headers: { 'Content-Type' => 'text/xml' })

    places = BeermappingApi.places_in('tampere')

    expect(places.size).to eq(3)

    expect(places[0].name).to eq("O'Connell's Irish Bar")
    expect(places[0].street).to eq('Rautatienkatu 24')
    expect(places[1].name).to eq('Heavy Corner')
    expect(places[1].street).to eq('Oluttie 4')
    expect(places[2].name).to eq('Pub Ruusu')
    expect(places[2].street).to eq('Tuoppikuja 3')
  end
end