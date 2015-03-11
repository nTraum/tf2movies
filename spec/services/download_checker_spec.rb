require "rails_helper"

describe DownloadChecker do
  let(:download) { build(:download) }

  describe ".check_status!" do
    after do
      expect(download.status_refreshed_at).to be_within(200).of(Time.now)
    end

    context "when the HTTP response is 200 and has a content length" do
      let (:content_length) { 123 }

      before do
        stub_request(:head, download.url).to_return(headers: { "Content-Length" => content_length })
        described_class.check_status!(download)
      end

      it "sets the download to online" do
        expect(download).to be_online
      end
    end
  end
end
