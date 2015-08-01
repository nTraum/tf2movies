require "rails_helper"

RSpec.describe GameMode, type: :model do
  it "generates a new friendly ID when the name changed" do
    original_name = "foo"
    new_name = "bar"

    game_mode = described_class.create(name: original_name)

    expect { game_mode.update(name: new_name) }.to change { game_mode.friendly_id }.from(original_name).to(new_name)
  end
end
