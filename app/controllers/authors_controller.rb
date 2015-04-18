class AuthorsController < ApplicationController
  def show
    author = Author.includes(:movies).friendly.find(params[:id])
    render(locals: { author: author} )
  end

  def index
  end
end
