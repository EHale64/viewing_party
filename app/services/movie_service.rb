class MovieService
  def self.top_rated_movies
    page = 1
    movies = []
    until movies.flatten.length >= 40
      response = conn.get('/3/movie/top_rated') do |f|
        f.params['page'] = page
        f.params['language'] = 'en-US'
      end
      json = JSON.parse(response.body, symbolize_names: true)
      movies << json[:results]
      page += 1
    end
    movies.flatten.first(40)
  end

  def self.movies_search(keyword)
    page = 1
    movies = []
    until movies.flatten.length >= 40
      response = conn.get('/3/search/movie') do |f|
        f.params['page'] = page
        f.params['language'] = 'en-US'
        f.params['query'] = keyword
        f.params['include_adult'] = false
      end
      json = JSON.parse(response.body, symbolize_names: true)
      movies << json[:results]
      page += 1
      break if page == 3
    end
    movies.flatten.first(40)
  end

  def self.movie_details(id)
    response = conn.get("/3/movie/#{id}&language=en-US")
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.cast(id)
    response = conn.get("/3/movie/#{id}/credits")
    json = JSON.parse(response.body, symbolize_names: true)
    json[:cast].first(10)
  end

  def self.reviews(id)
    response = conn.get("/3/movie/#{id}/reviews?language=en-US&page=1")
    json = JSON.parse(response.body, symbolize_names: true)
    json[:results]
  end

  def self.movie_trailer(id)
    response = conn.get("/3/movie/#{id}/videos?language=en-US")
    json = JSON.parse(response.body, symbolize_names: true)
    json[:results].first
  end

  def self.conn
    Faraday.new(url: 'https://api.themoviedb.org') do |f|
      f.params['api_key'] = ENV['TMDB_API_KEY']
    end
  end
end
