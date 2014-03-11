require 'test_helper'

describe Download do
  subject { [] <<
    FactoryGirl.build(:no_prefix) <<
    FactoryGirl.build(:download) <<
    FactoryGirl.build(:https) <<
    FactoryGirl.build(:subdomain) <<
    FactoryGirl.build(:http_www) <<
    FactoryGirl.build(:https_www)
  }

  it 'must be valid' do
    subject.each do |download|
      download.must_be_instance_of Download
      download.valid?.must_equal true
    end
  end

  it 'must derive the correct domain' do
    subject.each do |download|
      download.host.must_equal 'example.com', "Wrong host for: '#{download.host}'"
    end
  end

  it 'must change the status to online when the web server answers 200' do
    download = FactoryGirl.build :url_online_200
    VCR.use_cassette('download_test_refresh_status_200') do
      download.refresh_status
    end
    download.online?.must_equal true
    download.status_refreshed_at.must_be_within_delta(Time.current, 3)
  end

  it 'must change the status to offline when the web server answers 404' do
    download = FactoryGirl.build :url_offline_404
    VCR.use_cassette('download_test_refresh_status_404') do
      download.refresh_status
    end
    download.offline?.must_equal true
    download.status_refreshed_at.must_be_within_delta(Time.current, 3)
  end

  it 'must change the status to unknown when the web server answers differently' do
    download = FactoryGirl.build :url_offline_403
    VCR.use_cassette('download_test_refresh_status_403') do
      download.refresh_status
    end
    download.unknown?.must_equal true
    download.status_refreshed_at.must_be_within_delta(Time.current, 3)
  end

  it 'must change the status to unknown when the host is unknown' do
    download = FactoryGirl.build :url_offline_host_unknown
    download.refresh_status
    download.unknown?.must_equal true
    download.status_refreshed_at.must_be_within_delta(Time.current, 3)
  end
end