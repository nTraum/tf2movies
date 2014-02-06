class AuthorsController < ApplicationController
  def show
    @author = Author.find(params[:id])
  end

  def index
  end
end
