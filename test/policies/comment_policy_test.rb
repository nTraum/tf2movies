require 'test_helper'

describe CommentPolicy do
  let(:comment) { FactoryGirl.build(:comment) }

  describe 'as a visitor' do
    let(:user)  { nil }
    subject     { CommentPolicy.new(user, comment) }

    it 'does not allow to new' do
      subject.new?.must_equal false
    end
    it 'does not allow to create' do
      subject.create?.must_equal false
    end
  end

  describe 'as a user' do
    let(:user)  { FactoryGirl.build :user }
    subject     { CommentPolicy.new(user, comment) }

    it 'does allow to new' do
      subject.new?.must_equal true
    end
    it 'does allow to create' do
      subject.create?.must_equal true
    end
  end
  describe 'as a moderator' do
    let(:user)  { FactoryGirl.build :moderator }
    subject     { CommentPolicy.new(user, comment) }

    it 'does allow to new' do
      subject.new?.must_equal true
    end
    it 'does allow to create' do
      subject.create?.must_equal true
    end

  end

  describe 'as an admin' do
    let(:user)  { FactoryGirl.build :admin }
    subject     { CommentPolicy.new(user, comment) }

    it 'does allow to new' do
      subject.new?.must_equal true
    end
    it 'does allow to create' do
      subject.create?.must_equal true
    end
  end

  describe 'as a banned user' do
    let(:user)  { FactoryGirl.build :banned }
    subject     { CommentPolicy.new(user, comment) }

    it 'does not allow to new' do
      subject.new?.must_equal false
    end
    it 'does not allow to create' do
      subject.create?.must_equal false
    end
  end
end