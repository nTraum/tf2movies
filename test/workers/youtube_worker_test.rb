require 'test_helper'
require 'sidekiq/testing'

describe YoutubeWorker do
  describe 'qeueing' do
    it 'must start with zero jobs' do
      YoutubeWorker.jobs.size.must_equal 0
    end
    it 'must increase job size when adding a job'
  end

  describe 'refreshing youtube movie info' do
    it 'must have a good test'
  end
end