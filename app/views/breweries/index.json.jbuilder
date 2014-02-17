json.array!(@breweries) do |brewery|
  json.extract! brewery, :name, :year
  json.beer_count Beer.where(brewery_id: brewery.id).count
end
