class AuthorsController < ApplicationController
  def show
    @author = Author.friendly.find(params[:id])
  end

  def index
  end
end
