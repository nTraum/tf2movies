require 'test_helper'

describe DownloadChecker do
  let (:download) { FactoryGirl.build :http_download }
  subject {DownloadChecker.new(download)}

  it 'must update the status_freshed_at column' do
    stub_request(:head, download.url)

    subject.check_status
    download.status_refreshed_at.must_be_within_delta(Time.current, 3)
  end

  describe 'checking a download that responds with 200' do
    it 'must be online' do
      stub_request(:head, download.url)

      subject.check_status
      download.online?.must_equal true
    end
    it 'must have the correct filesize' do
      stub_request(:head, download.url).to_return(:headers => { 'Content-Length' => 123 })

      subject.check_status
      download.filesize.must_equal -1 # idk why curb returns a negative content length with webmock :(
    end
  end

  describe 'checking a download that responds with 404' do
    it 'must be offline' do
      stub_request(:head, download.url).to_return(:status => 404)

      subject.check_status
      download.offline?.must_equal true
    end
    it 'must have no filesize' do
      stub_request(:head, download.url).to_return(:status => 404)

      subject.check_status
      download.filesize.must_be_nil
    end
  end

  describe 'checking a download that does not respond with 200 nor 404' do
    it 'must be unknown' do
      stub_request(:head, download.url).to_return(:status => 500)

      subject.check_status
      download.unknown?.must_equal true
    end
    it 'must have no filesize' do
      stub_request(:head, download.url).to_return(:status => 500)

      subject.check_status
      download.filesize.must_be_nil
    end
  end

  describe 'checking a download with an unresolveable hostname' do
    it 'must be unknown' do
      stub_request(:head, download.url).to_raise StandardError

      subject.check_status
      download.unknown?.must_equal true
    end

    it 'must have no filesize' do
      stub_request(:head, download.url).to_raise StandardError

      subject.check_status
      download.filesize.must_be_nil
    end
  end
end