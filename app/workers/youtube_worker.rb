class YoutubeWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence { minutely 5 }

  def perform
    movie = get_oldest_movie
    if movie
      movie.refresh_youtube_info
    end
  end

  private

  def get_oldest_movie
    Movie.order(:updated_at).first
  end
end