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
    @featured_movies = Movie.publisheds.featured.order(:featured_at => :desc).limit(5)
  end

  def recent
    @most_recent_movies = Movie.publisheds.order(:status_changed_at => :desc).limit(5)
  end

  def popular
    @most_viewed_movies = Movie.publisheds.order(:views => :desc).limit(5)
  end

  def stats
    @movies_count           = Movie.publisheds.size
    @total_duration_in_hrs  = Movie.publisheds.sum(:duration) / 60 / 60
  end

  def staff_members
    @admins     = User.where(:role_cd => User.admin)
    @moderators = User.where(:role_cd => User.moderator)
  end
end
