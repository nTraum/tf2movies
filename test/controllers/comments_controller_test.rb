require 'test_helper'

describe CommentsController do
  describe 'create' do
    it 'must create movie comments' do
      as_logged_in_user do
        movie = FactoryGirl.create :movie
        post :create, { :movie_id => movie.id, :comment => FactoryGirl.attributes_for(:comment) }
        response.status.must_equal 302
        flash[:notice].wont_be_nil
        movie.comments.size.must_equal 1
      end
    end
    it 'must redirect and display an error message when submitting an invalid comment' do
      as_logged_in_user do
        movie = FactoryGirl.create :movie
        post :create, { :movie_id => movie.id, :comment => FactoryGirl.attributes_for(:comment, :text => nil) }
        response.status.must_equal 302
        flash[:alert].wont_be_nil
        movie.comments.size.must_equal 0
      end
    end
  end
end
