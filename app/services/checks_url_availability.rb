class ChecksUrlAvailability
  HTTP_SUCCESS   = 200
  HTTP_NOT_FOUND = 404

  def initialize(download)
    Rails.logger.info("Checking download ##{download.id}: #{download.url}.")
    response = http_response(download.url)

    if response[:status_code] == HTTP_SUCCESS
      download.online!
    elsif response[:status_code] == HTTP_NOT_FOUND
      download.offline!
    else
      download.unknown!
    end

    download.filesize = response[:filesize]
    download.status_refreshed_at = Time.zone.now
    download.save!
  end

  private

  def http_response(url)
    begin
      response = Curl::Easy.http_head(url) do |c|
        c.follow_location = true
        c.max_redirects = 10
      end
      status_code = response.response_code
      filesize = response.downloaded_content_length.to_i
    rescue => e
      Rails.logger.warn "Error while checking URL '#{url}': #{e.class}, #{e.message}."
      status_code = 500
      filesize = nil
    end

    { status_code: status_code, filesize: filesize }
  end
end
