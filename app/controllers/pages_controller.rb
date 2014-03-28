class PagesController < ApplicationController

  before_action :staff_members,                       :only => :about
  before_action :stats, :featured, :recent, :popular, :only => :welcome

  def not_found
    render 'not_found', :status => 404
  end

  def internal_error
    render 'internal_error', :status => 500
  end

  private

  def featured
    @featured_movies = Movie.featured.limit(5)
  end

  def recent
    @most_recent_movies = Movie.order(:created_at => :desc).limit(5)
  end

  def popular
    @most_viewed_movies = Movie.order(:created_at => :desc).limit(5)
  end

  def stats
    @movies_count     = Movie.count
    @downloads_count  = Download.count
    @authors_count    = Author.count
    @total_duration   = Movie.sum(:duration)
  end

  def staff_members
    @admins     = User.where(:role_cd => User.admin)
    @moderators = User.where(:role_cd => User.moderator)
  end
end
