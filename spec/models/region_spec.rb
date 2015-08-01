require "rails_helper"

RSpec.describe Region, type: :model do
  it "generates a new friendly ID when the name changed" do
    original_name = "foo"
    new_name = "bar"

    region = described_class.create(name: original_name)

    expect { region.update(name: new_name) }.to change { region.friendly_id }.from(original_name).to(new_name)
  end
end
