require "rails_helper"

RSpec.describe Download, type: :model do
  subject { described_class.new }

  it "must have an unknown status by default" do
    subject.save

    expect(subject).to be_unknown
  end

  describe "#host" do
    shared_examples "a download whose host is example.com" do
      specify { expect(subject.host).to eq "example.com" }
    end

    context "when the URL has a 'HTTP://'' prefix" do
      before { subject.url = "http://example.com/movie.mp4" }
      it_behaves_like "a download whose host is example.com"
    end

    context "when the URL has a 'HTTPS://'' prefix" do
      before { subject.url = "https://example.com/movie.mp4" }
      it_behaves_like "a download whose host is example.com"
    end

    context "when there is no protocol in the URL" do
      before { subject.url = "example.com/movie.mp4" }
      it_behaves_like "a download whose host is example.com"
    end

    context "when the URL has a subdomain" do
      before { subject.url = "http://subdomain.example.com/movie.mp4" }
      it_behaves_like "a download whose host is example.com"
    end

    context "when the URL has a 'HTTP://www' prefix" do
      before { subject.url = "http://www.example.com/movie.mp4" }
      it_behaves_like "a download whose host is example.com"
    end
  end
end
