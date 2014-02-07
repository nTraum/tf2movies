class DownloadStatusWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence { minutely 5 }

  def perform
    download = get_oldest_download
    if download
      download.refresh_status
    end
  end

  private

  def get_oldest_download
    Download.order(:updated_at).first
  end
end