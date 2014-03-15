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
    subject { FactoryGirl.build :url_200_download }
    it 'must be online after refreshing the status' do
      VCR.use_cassette(__name__) do
        subject.refresh_status
      end
      subject.online?.must_equal true
      subject.status_refreshed_at.must_be_within_delta(Time.current, 3)
    end
  end

  describe 'with URL pointing to 404 response' do
    subject { FactoryGirl.build :url_404_download }
    it 'must be offline after refreshing the status' do
      VCR.use_cassette(__name__) do
        subject.refresh_status
      end
      subject.offline?.must_equal true
      subject.status_refreshed_at.must_be_within_delta(Time.current, 3)
    end
  end

  describe 'with URL pointing to a response not being 200 or 404' do
    subject { FactoryGirl.build :url_403_download }
    it 'must be unknown after refreshing the status' do
      VCR.use_cassette(__name__) do
        subject.refresh_status
      end
      subject.unknown?.must_equal true
      subject.status_refreshed_at.must_be_within_delta(Time.current, 3)
    end
  end

  describe 'with URL pointing to an unknown domain' do
    subject { FactoryGirl.build :url_domain_unknown }
    it 'must be unknown after refreshing the status' do
      VCR.use_cassette(__name__) do
        subject.refresh_status
      end
      subject.unknown?.must_equal true
      subject.status_refreshed_at.must_be_within_delta(Time.current, 3)
    end
  end
end