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

  it 'must refresh the status' do
    download = FactoryGirl.create :no_status_check
    VCR.use_cassette('download_test_refresh_status_200') do
      download.refresh_status
    end
    download.online?.must_equal true
    download.status_refreshed_at.must_be_within_delta(Time.current, 3)
  end
end