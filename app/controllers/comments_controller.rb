class CommentsController < ApplicationController
  after_action :verify_authorized

  def create
    @comment = Comment.new(comments_params)
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
    params.require(:comment).permit(:movie_id, :text)
  end
end
