require 'test_helper'

describe Download do

  it 'must have an unknown status when created' do
    FactoryGirl.create(:download).unknown?.must_equal true
  end
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
end