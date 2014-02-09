class PlacesController < ApplicationController
  def index
  end

  def search
    api_key = '1c062c8dced5c4374a302f0810a1f46a'
    url = "http://beermapping.com/webservice/loccity/#{api_key}/"
    response = HTTParty.get "#{url}#{params[:city]}"
    places = response.parsed_response['bmp_locations']['location']

    if places.is_a?(Hash) and places['id'].nil?
      redirect_to places_path, :notice => "No places in #{params[:city]}"
    else
      places = [places] if places.is_a?(Hash)
      @places = places.inject([]) do | set, place |
        set << Place.new(place)
      end
      render :index
    end
  end
end