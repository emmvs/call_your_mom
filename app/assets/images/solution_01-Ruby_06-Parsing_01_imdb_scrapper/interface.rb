require "yaml"
require_relative "scraper"

puts "Fetching URLs"
urls = fetch_movie_urls

movies = urls.map do |url|
  puts "Scraping #{url}"
  scrape_movie(url)
end

puts "Writing movies.yml"
File.write("movies.yml", movies.to_yaml)

puts "Done."
