require "rails_helper"

RSpec.describe Comment, type: :model do
  it "sanitizes the comment text before validation" do
    unsanitized_text = "foo <img src=\"http://placehold.it/1x1\"> bar"
    sanitized_text = "foo  bar"

    comment = described_class.new(text: unsanitized_text)

    expect{ comment.save }.to change{ comment.text }.from(unsanitized_text).to(sanitized_text)
  end
end
