require "rails_helper"

describe DownloadChecker do
  let(:download) { build(:download) }

  describe ".check_status!" do
    after { expect(download.status_refreshed_at).to be_within(2).of(Time.zone.now) }

    context "when the HTTP response is 200 and has a content length" do
      let(:status) { 200 }

      before { stub_request(:head, download.url).to_return(status: status) }

      it "sets the download to online" do
        described_class.check_status!(download)
        expect(download).to be_online
      end
    end

    context "when the HTTP response is 404" do
      let(:status) { 404 }

      before { stub_request(:head, download.url).to_return(status: status) }

      it "sets the download to offline" do
        described_class.check_status!(download)
        expect(download).to be_offline
      end
    end

    context "when the HTTP request times out" do
      before { stub_request(:head, download.url).to_timeout }

      it "sets the download to offline" do
        described_class.check_status!(download)
        expect(download).to be_unknown
      end
    end
  end
end
