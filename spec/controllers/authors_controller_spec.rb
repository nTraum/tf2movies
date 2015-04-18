require 'rails_helper'

RSpec.describe AuthorsController, type: :controller do

  describe "GET #show" do
    let(:author) { create(:author) }
    before { get(:show, id: author.friendly_id) }

    it "returns HTTP success" do
      expect(response).to have_http_status(:success)
    end

    it "renders the show template" do
      expect(response).to render_template(:show)
    end
  end

  describe "GET #index" do
    before { get(:index) }

    it "returns HTTP success" do
      expect(response).to have_http_status(:success)
    end

    it "renders the index template" do
      expect(response).to render_template(:index)
    end
  end

end
