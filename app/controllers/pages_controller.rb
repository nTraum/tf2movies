class PagesController < ApplicationController
  def about
  end

  def welcome
    @movies_count       = Movie.count
    @downloads_count    = Download.count
    @authors_count      = Author.count
    @total_duration     = Movie.sum(:duration)
    @most_recent_movies = Movie.order(:created_at => :desc).limit(5)
    @most_viewed_movies = Movie.order(:views => :desc).limit(5)
  end

  def contact
  end

  def not_found
    render 'not_found', :status => 404
  end

  def internal_error
    render 'internal_error', :status => 500
  end
end
