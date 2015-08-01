class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @movies = @user.movies.where(status_cd: Movie.published)
  end

  def index
    @users = User.all
  end
end
