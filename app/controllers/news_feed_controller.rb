class NewsFeedController < ApplicationController
  def feed
    @title = 'TF2Movies'
    @movies = Movie.publisheds.includes(:author).order(created_at: :desc)
    @updated = @movies.first.created_at if @movies.any?

    respond_to do |format|
      format.atom { render layout: false }
      format.rss { redirect_to(feed_path(format: :atom), status: :moved_permanently) }
    end
  end
end
