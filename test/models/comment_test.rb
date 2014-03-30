require 'test_helper'

describe Comment do
  it 'must be valid' do
    FactoryGirl.build(:comment).valid?.must_equal true
  end

  it 'must strip naughty HTML tags from comments' do
    comment = FactoryGirl.create(:naughty_comment)
    comment.text.must_equal 'haha did you see this image?'
  end
end
