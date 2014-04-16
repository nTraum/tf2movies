class SearchController < ApplicationController

  def search
    @movies = Movie.search(params[:q])
    @authors = Author.search(params[:q])
    @users = User.search(params[:q])
  end

end
