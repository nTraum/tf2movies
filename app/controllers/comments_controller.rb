class CommentsController < ApplicationController
  after_action :verify_authorized

  def create
    @movie = Movie.friendly.find(comments_params[:movie_id])
    @comment = @movie.comments.build(comments_params[:comment])
    @comment.user = current_user
    authorize @comment
    if @comment.save
      redirect_to movie_path(@comment.movie), :notice => 'Comment added.'
    else
      redirect_to movie_path(@comment.movie), :alert => @comment.errors.full_messages.join(', ')
    end
  end

  def update
  end

  def edit
  end

  private

  def comments_params
    params.permit(:movie_id, :comment => [:text])
  end
end
