require 'faraday'
require 'json'
require 'pry'
require_relative 'film'

class FilmSearch
  def film_information
    service.films.map do |data|
      Film.new(data)
    end
  end

  def service
    GhibliService.new
  end
end

class GhibliService
  def films
    get_url("films")
  end

  def people
    get_url("people")
  end

  def locations
    get_url("locations")
  end

  def get_url(url)
    response = Faraday.get("https://ghibliapi.herokuapp.com/#{url}")
    JSON.parse(response.body, symbolize_names: true)
  end

end


film_search = FilmSearch.new

film_search.film_information.each do |film|
  puts film.title
  puts "Directed By: #{film.director}"
  puts "Produced By: #{film.producer}"
  puts "Rotten Tomatoes Score: #{film.rotten_tomatoes}"
  puts ""
end
