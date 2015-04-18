require "rails_helper"

RSpec.describe NewsFeedController, type: :controller do
  describe "#feed" do
    subject { get(:feed, format: format) }
    context "with atom format" do
      let(:format) { :atom }

      it "responds with HTTP 200" do
        expect(subject).to be_successful
      end
    end

    context "with rss format" do
      let(:format) { :rss }

      it "responds with HTTP 301" do
        expect(subject).to be_redirect
      end
    end
  end
end
