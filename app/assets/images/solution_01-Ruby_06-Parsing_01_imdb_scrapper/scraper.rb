require "open-uri"
require "nokogiri"

USER_AGENT = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36"

def fetch_movie_urls
  top_url = "https://www.imdb.com/chart/top/"
  doc = Nokogiri::HTML.parse(URI.parse(top_url).open("Accept-Language" => "en-US", "User-Agent" => USER_AGENT).read)
  movies = doc.search("a.ipc-title-link-wrapper")
  movies.take(5).map do |movie|
    uri = URI.parse(movie.attributes["href"].value)
    uri.scheme = "https"
    uri.host = "www.imdb.com"
    uri.query = nil
    uri.to_s
  end
end

def scrape_movie(url)
  doc = Nokogiri::HTML.parse(URI.parse(url).open("Accept-Language" => "en-US", "User-Agent" => USER_AGENT).read)

  title = doc.search("h1").text
  year = doc.search(".ipc-inline-list__item")[4].text.to_i
  summary = doc.search('.sc-466bb6c-0').text
  director = doc.search('.ipc-metadata-list__item:contains("Director") a').first.text
  cast = doc.search('.ipc-metadata-list__item:contains("Stars") a.ipc-metadata-list-item__list-content-item').map { |element| element.text }.uniq

  {
    title: title,
    cast: cast,
    director: director,
    summary: summary,
    year: year
  }
end
