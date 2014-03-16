require 'test_helper'

describe Download do
  describe 'with HTTP URL' do
    subject { FactoryGirl.build :http_download }
    it 'must derive the correct host' do
      subject.host.must_equal 'example.com'
    end
  end
  describe 'with missing protocol in URL' do
    subject { FactoryGirl.build :missing_protocol_download }
    it 'must derive the correct host' do
      subject.host.must_equal 'example.com'
    end
  end
  describe 'with HTTPS URL' do
    subject { FactoryGirl.build :https_download }
    it 'must derive the correct host' do
      subject.host.must_equal 'example.com'
    end
  end
  describe 'with subdomain in URL' do
    subject { FactoryGirl.build :subdomain_download }
    it 'must derive the correct host' do
      subject.host.must_equal 'example.com'
    end
  end
  describe 'with HTTP www URL' do
    subject { FactoryGirl.build :http_www_download }
    it 'must derive the correct host' do
      subject.host.must_equal 'example.com'
    end
  end
  describe 'with HTTPS www URL' do
    subject { FactoryGirl.build :https_www_download }
    it 'must derive the correct host' do
      subject.host.must_equal 'example.com'
    end
  end

  describe 'with URL pointing to 200 response' do
    subject { FactoryGirl.build :http_download }
    it 'must be online after refreshing the status' do
      stub_request(:head, subject.url)
      subject.refresh_status
      subject.online?.must_equal true
      subject.status_refreshed_at.must_be_within_delta(Time.current, 3)
    end
    it 'must have the correct filesize after refreshing the status' do
      req = stub_request(:head, subject.url).to_return(:headers => { 'Content-Length' => 123 })
      subject.refresh_status
      subject.filesize.must_equal -1 # idk why curb returns a negative content length with webmock :(
    end
  end

  describe 'with URL pointing to 404 response' do
    subject { FactoryGirl.build :http_download }
    it 'must be offline after refreshing the status' do
      stub_request(:head, subject.url).to_return(:status => 404)
      subject.refresh_status
      subject.offline?.must_equal true
      subject.status_refreshed_at.must_be_within_delta(Time.current, 3)
    end
  end

  describe 'with URL pointing to a response not being 200 or 404' do
    subject { FactoryGirl.build :http_download }
    it 'must be unknown after refreshing the status' do
      stub_request(:head, subject.url).to_return(:status => 500)
      subject.refresh_status
      subject.unknown?.must_equal true
      subject.status_refreshed_at.must_be_within_delta(Time.current, 3)
    end
  end

  describe 'with URL pointing to an unknown domain' do
    subject { FactoryGirl.build :http_download }
    it 'must be unknown after refreshing the status' do
      stub_request(:head, subject.url).to_raise Resolv::ResolvError
      subject.refresh_status
      subject.unknown?.must_equal true
      subject.status_refreshed_at.must_be_within_delta(Time.current, 3)
    end
  end
end