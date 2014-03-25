require 'test_helper'

describe CommentPolicy do
  let(:comment) { FactoryGirl.build(:comment) }

  describe 'as a visitor' do
    let(:user)  { nil }
    subject     { CommentPolicy.new(user, comment) }

    it 'does not allow to new' do
      subject.new?.must_equal false
    end
  end
end