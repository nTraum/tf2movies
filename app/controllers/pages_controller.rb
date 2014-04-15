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
    @featured_movies = Movie.where(:status_cd => Movie.published).featured.order(:featured_at => :desc).limit(5)
  end

  def recent
    @most_recent_movies = Movie.where(:status_cd => Movie.published).order(:created_at => :desc).limit(5)
  end

  def popular
    @most_viewed_movies = Movie.where(:status_cd => Movie.published).order(:views => :desc).limit(5)
  end

  def stats
    @movies_count     = Movie.where(:status_cd => Movie.published).size
    @downloads_count  = Download.joins(:movie).where(:movies => { :status_cd => Movie.published }).size
    @authors_count    = Author.joins(:movies).where(:movies => {:status_cd => Movie.published}).uniq.size
    @total_duration   = Movie.where(:status_cd => Movie.published).sum(:duration)
  end

  def staff_members
    @admins     = User.where(:role_cd => User.admin)
    @moderators = User.where(:role_cd => User.moderator)
  end
end