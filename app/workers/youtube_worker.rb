class YoutubeWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence { minutely 5 }

  def perform
    movie = get_oldest_movie
    if movie
      movie.refresh_info
    end
  end

  private

  def get_oldest_movie
    Movie.order(:info_refreshed_at).first
  end
end