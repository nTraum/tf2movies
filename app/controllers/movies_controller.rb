class MoviesController < ApplicationController
  after_action :verify_authorized, :except => [:submit, :show]

  def submit
    @movie = Movie.new
  end

  def show
    @movie = Movie.includes(:author, :downloads, :songs, :comments).find(params[:id])
    @comment = Comment.new
  end

  def edit
    @movie = Movie.includes(:author, :downloads, :songs).find(params[:id])
    authorize @movie
  end

  def create
    begin
      @movie = Movie.new
      authorize @movie
      @movie.new_with_youtube_it(params[:url], current_user)
      if @movie.save
        redirect_to submit_movies_path, :notice => "'#{@movie.title}' has been successfully submitted. Thanks for telling us!"
      else
        redirect_to submit_movies_path, :alert => @movie.errors.full_messages.join(', ')
      end
    rescue OpenURI::HTTPError => e
      flash[:warning] = "Unable to find YouTube video at <a href=\"#{params[:url]}\">#{params[:url]}</a>. Typo?"
      redirect_to submit_movies_path
    end
  end

  def update
    @movie = Movie.find(params[:id])
    authorize @movie

    if @movie.update(movie_params)
      redirect_to movie_path(@movie), :notice => 'Movie updated.'
    else
      redirect_to movie_path(@movie), :alert => @movie.errors.full_messages.join(', ')
    end
  end

  private

  def movie_params
    params.require(:movie).permit(:game_mode_id, :tf2_class_id, :region_id, :featured, :status, :songs_attributes => [:id, :artist, :title, :_destroy], :downloads_attributes => [:id, :url, :_destroy])
  end
end
