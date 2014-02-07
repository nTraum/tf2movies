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
      download.host.must_equal 'fakkelbrigade.eu', "Wrong host for: '#{download.host}'"
    end
  end
end