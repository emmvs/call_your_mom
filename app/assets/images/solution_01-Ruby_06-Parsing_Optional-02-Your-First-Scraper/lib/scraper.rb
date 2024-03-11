require "open-uri"
require "nokogiri"

def scrape_craiglist_antiques(city)
  # TODO: return an array of Antiques found of Craigslist for this `city`.
  doc = Nokogiri::HTML.parse(URI.open("http://#{city}.craigslist.org/search/ata"))
  doc.search('.hdrlnk').map(&:text)
end
