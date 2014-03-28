class DownloadChecker
  attr_reader :download

  def initialize(download)
    @download = download
  end

  def check_status
    response = http_response(@download.url)

    if response[:status_code] == 200
      @download.online!
      @download.filesize = response[:filesize]
    elsif response[:status_code] == 404
      @download.offline!
      @download.filesize = nil
    else
      @download.unknown!
      @download.filesize = nil
    end

    @download.status_refreshed_at = DateTime.now
    @download.save!
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
    rescue
      status_code = 500
      filesize = nil
    end

    return {:status_code => status_code, :filesize => filesize}
  end
end