class YoutubeWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence { minutely 5 }
  def perform
    Movie.refresh_youtube_info
  end
end