class AuthorsController < ApplicationController
  def show
    @author = Author.includes(:movies).friendly.find(params[:id])
    @movies = @author.movies.where(:status_cd => Movie.published)
  end

  def index
  end
end
