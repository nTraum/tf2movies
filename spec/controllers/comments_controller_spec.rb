require "rails_helper"

RSpec.describe CommentsController, type: :controller do
  describe "POST #create" do
    before { allow(controller).to receive(:current_user) { create(:user) } }
    let(:movie) { create(:movie) }
    context "when the comment text is not empty" do
      let(:text) { "foo" }

      it "adds the comment to the movie" do
        expect { post(:create, movie_id: movie.friendly_id, comment: { text: text }) }
          .to change { movie.comments.count }.by(1)
      end

      it "redirects to the movie" do
        post(:create, movie_id: movie.friendly_id, comment: { text: text })
        expect(response).to redirect_to(movie)
      end

      it "sets the notice flash" do
        post(:create, movie_id: movie.friendly_id, comment: { text: text })
        expect(flash[:notice]).to be_present
      end
    end

    context "when the comment text is empty" do
      let(:text) { nil }
      before { post(:create, movie_id: movie.friendly_id, comment: { text: text }) }

      it "does not add the comment to the movie" do
        expect(movie.comments).to be_empty
      end

      it "redirects to the movie" do
        expect(response).to redirect_to(movie)
      end

      it "sets the alert flash" do
        expect(flash[:alert]).to be_present
      end
    end
  end
end
