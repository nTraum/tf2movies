require 'test_helper'

describe DownloadStatusWorker do
  describe 'qeueing' do
    it 'must start with zero jobs' do
      DownloadStatusWorker.jobs.size.must_equal 0
    end
    it 'must increase job size when adding a job'
  end

  describe 'refreshing download status' do
    it 'must have a good test'
  end
end