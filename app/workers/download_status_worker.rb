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
    Download.where(:status_refreshed_at => nil).first || Download.order(:status_refreshed_at).first
  end
end