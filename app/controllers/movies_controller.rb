class MoviesController < ApplicationController
  def index; end

  def top_movies
    @movies = MovieDataBaseFacade.top_rated_movies
  end

  def top_search
    @movies = MovieDataBaseFacade.movies_search(params[:find_movies])
    if @movies.empty?
      flash[:notice] = 'No Movies Match Your Search'
    end
  end

  def show
    @movie = MovieDataBaseFacade.movie_details(params[:id])
    @cast = MovieDataBaseFacade.movie_cast(params[:id])
    @reviews = MovieDataBaseFacade.movie_reviews(params[:id])
    @trailer = MovieDataBaseFacade.movie_trailer(params[:id])
  end
end
