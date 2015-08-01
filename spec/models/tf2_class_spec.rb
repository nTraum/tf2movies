require "rails_helper"

RSpec.describe Tf2Class, type: :model do
  it "generates a new friendly ID when the name changed" do
    original_name = "foo"
    new_name = "bar"

    tf2_class = described_class.create(name: original_name)

    expect { tf2_class.update(name: new_name) }.to change { tf2_class.friendly_id }.from(original_name).to(new_name)
  end
end
