require 'pry'
require 'httparty'
class Place
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def get_info
    encoded_uri = URI.encode("https://maps.googleapis.com/maps/api/place/textsearch/json?query=#{@name}&language=en&key=AIzaSyCBNp7R2Yc2-bgjqhMoCdGXAy7Y8Ndd3v4")
    HTTParty.get(encoded_uri).parsed_response
  end

  def find_lat_long
    info = self.get_info
    if info["status"] == "OK"
      return info["results"][0]["geometry"]["location"]
    else
      return "Location can't be found"
    end
  end

end

seven_wonders = ["Great Pyramid of Giza", "Hanging Gardens of Babylon", "Colossus of Rhodes", "Pharos of Alexandria", "Statue of Zeus at Olympia", "Temple of Artemis", "Mausoleum at Halicarnassus"]

seven_wonders.each_with_index do |w, index|
  place = Place.new(w)
  seven_wonders[index] = place
end

locations = {}
seven_wonders.each do |w|
  locations[w.name] = w.find_lat_long
end

puts locations.inspect


#Example Output:
#{"Great Pyramind of Giza"=>{"lat"=>29.9792345, "lng"=>31.1342019}, "Hanging Gardens of Babylon"=>{"lat"=>32.5422374, "lng"=>44.42103609999999}, "Colossus of Rhodes"=>{"lat"=>36.45106560000001, "lng"=>28.2258333}, "Pharos of Alexandria"=>{"lat"=>38.7904054, "lng"=>-77.040581}, "Statue of Zeus at Olympia"=>{"lat"=>37.6379375, "lng"=>21.6302601}, "Temple of Artemis"=>{"lat"=>37.9498715, "lng"=>27.3633807}, "Mausoleum at Halicarnassus"=>{"lat"=>37.038132, "lng"=>27.4243849}}
