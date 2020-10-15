class Movie
  attr_reader :title,
              :vote_average,
              :runtime,
              :genres,
              :summary,
              :id

  def initialize(movie_data)
    @title = movie_data[:title]
    @vote_average = movie_data[:vote_average]
    @runtime = movie_data[:runtime]
    @genres = movie_data[:genres].map { |genre| genre[:name] } if movie_data[:genres]
    @summary = movie_data[:overview]
    @id = movie_data[:id]
  end
end
