class SearchController < ApplicationController
  def search
    @movies = Movie.where(status_cd: Movie.published).search(params[:q])
    @authors = Author.search(params[:q])
    @users = User.search(params[:q])
  end
end
