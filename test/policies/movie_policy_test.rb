require 'test_helper'

describe MoviePolicy do
  let(:movie) { FactoryGirl.build(:movie) }

  describe 'as a visitor' do
    let(:user)  { nil }
    subject     { MoviePolicy.new(user, movie) }

    it 'does not allow to manage' do
      subject.manage?.must_equal false
    end
    it 'does not allow to submit' do
      subject.submit?.must_equal false
    end
    it 'does not allow to create' do
      subject.create?.must_equal false
    end
    it 'does not allow to edit' do
      subject.edit?.must_equal false
    end
    it 'does not allow to update' do
      subject.update?.must_equal false
    end
  end

  describe 'as a user' do
    let(:user)  { FactoryGirl.build(:user) }
    subject     { MoviePolicy.new(user, movie) }

    it 'does not allow to manage' do
      subject.manage?.must_equal false
    end
    it 'allows to submit' do
      subject.submit?.must_equal true
    end
    it 'allows to create' do
      subject.create?.must_equal true
    end
    it 'does not allow to edit' do
      subject.edit?.must_equal false
    end
    it 'does not allow to update' do
      subject.update?.must_equal false
    end
  end

  describe 'as a banned user' do
    let(:user)  { FactoryGirl.build(:banned) }
    subject     { MoviePolicy.new(user, movie) }

    it 'does not allow to manage' do
      subject.manage?.must_equal false
    end
    it 'does not allow to submit' do
      subject.submit?.must_equal false
    end
    it 'does not allow to create' do
      subject.create?.must_equal false
    end
    it 'does not allow to edit' do
      subject.edit?.must_equal false
    end
    it 'does not allow to update' do
      subject.update?.must_equal false
    end
  end

  describe 'as a moderator' do
    let(:user)  { FactoryGirl.build(:moderator) }
    subject     { MoviePolicy.new(user, movie) }

    it 'allows to manage' do
      subject.manage?.must_equal true
    end
    it 'allows to submit' do
      subject.submit?.must_equal true
    end
    it 'allows to create' do
      subject.create?.must_equal true
    end
    it 'allows to edit' do
      subject.edit?.must_equal true
    end
    it 'allows to update' do
      subject.update?.must_equal true
    end
  end

  describe 'as an admin' do
    let(:user)  { FactoryGirl.build(:admin) }
    subject     { MoviePolicy.new(user, movie) }

    it 'allows to manage' do
      subject.manage?.must_equal true
    end
    it 'allows to submit' do
      subject.submit?.must_equal true
    end
    it 'allows to create' do
      subject.create?.must_equal true
    end
    it 'allows to edit' do
      subject.edit?.must_equal true
    end
    it 'allows to update' do
      subject.update?.must_equal true
    end
  end
end