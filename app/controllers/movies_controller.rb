class MoviesController < ApplicationController
  after_action :verify_authorized,  except: [:submit, :show, :index]

  def index
  end

  def submit
  end

  def love
    @movie = Movie.friendly.find(params[:id])
    authorize @movie
    if @movie.users.exists?(current_user.id)
      @movie.users.destroy(current_user)
      redirect_to movie_path(@movie), notice: "Movie unloved."
    else
      @movie.users << current_user
      redirect_to movie_path(@movie), notice: "Movie loved."
    end
  end

  def manage
    @pending_movies = Movie.where(status_cd: Movie.pending).order(:created_at)
    @published_movies = Movie.where(status_cd: Movie.published).order(:created_at)
    @rejected_movies = Movie.where(status_cd: Movie.rejected).order(:created_at)
    @incompletely_tagged_movies = @published_movies.where(["region_id IS ? OR game_mode_id IS ? OR tf2_class_id IS ?", nil, nil, nil]).order(:created_at)
    authorize @pending_movies
  end

  def show
    @movie = Movie.includes(:author, :downloads, :songs, :comments).friendly.find(params[:id])
    @comment = Comment.new
    @loved_from_user = !!(current_user && @movie.users.exists?(current_user.id))
  end

  def edit
    @movie = Movie.includes(:author, :downloads, :songs).friendly.find(params[:id])
    authorize @movie
  end

  def create
    @movie = Movie.new_with_url(params[:movie][:url], current_user)
    authorize @movie
    if @movie.save
      redirect_to submit_movies_path, notice: "'#{@movie.title}' has been successfully submitted. Thanks for telling us!"
    else
      redirect_to submit_movies_path, alert: [@movie.errors[:base], @movie.errors[:youtube_id]].compact.join
    end
  end

  def update
    @movie = Movie.friendly.find(params[:id])
    authorize @movie

    if @movie.update(movie_params)
      redirect_to movie_path(@movie), notice: "Movie updated."
    else
      redirect_to movie_path(@movie), alert: @movie.errors.full_messages.join(", ")
    end
  end

  private

  def movie_params
    params.require(:movie)
      .permit(:game_mode_id, :tf2_class_id, :region_id, :featured, :status,
              songs_attributes: [:id, :artist, :title, :_destroy],
              downloads_attributes: [:id, :url, :_destroy])
  end
end
