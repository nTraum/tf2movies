require 'test_helper'

describe CategoryPolicy do
  let(:category) { nil }

  describe 'as a visitor' do
    let(:user)  { nil }
    subject     { CategoryPolicy.new(user, category) }

    it 'does not allow to manage' do
      subject.manage?.must_equal false
    end
    it 'does not allow to edit' do
      subject.edit?.must_equal false
    end
    it 'does not allow to upate' do
      subject.update?.must_equal false
    end
    it 'does not allow to destroy' do
      subject.destroy?.must_equal false
    end
    it 'does not allow to create' do
      subject.create?.must_equal false
    end
    it 'does not allow to new' do
      subject.new?.must_equal false
    end
  end

  describe 'as a user' do
    let(:user)  { FactoryGirl.build :user }
    subject     { CategoryPolicy.new(user, category) }

    it 'does not allow to manage' do
      subject.manage?.must_equal false
    end
    it 'does not allow to edit' do
      subject.edit?.must_equal false
    end
    it 'does not allow to upate' do
      subject.update?.must_equal false
    end
    it 'does not allow to destroy' do
      subject.destroy?.must_equal false
    end
    it 'does not allow to create' do
      subject.create?.must_equal false
    end
    it 'does not allow to new' do
      subject.new?.must_equal false
    end
  end

  describe 'as a banned user' do
    let(:user)  { FactoryGirl.build :banned }
    subject     { CategoryPolicy.new(user, category) }

    it 'does not allow to manage' do
      subject.manage?.must_equal false
    end
    it 'does not allow to edit' do
      subject.edit?.must_equal false
    end
    it 'does not allow to upate' do
      subject.update?.must_equal false
    end
    it 'does not allow to destroy' do
      subject.destroy?.must_equal false
    end
    it 'does not allow to create' do
      subject.create?.must_equal false
    end
    it 'does not allow to new' do
      subject.new?.must_equal false
    end
  end

  describe 'as a moderator' do
    let(:user)  { FactoryGirl.build :moderator }
    subject     { CategoryPolicy.new(user, category) }

    it 'does not allow to manage' do
      subject.manage?.must_equal false
    end
    it 'does not allow to edit' do
      subject.edit?.must_equal false
    end
    it 'does not allow to upate' do
      subject.update?.must_equal false
    end
    it 'does not allow to destroy' do
      subject.destroy?.must_equal false
    end
    it 'does not allow to create' do
      subject.create?.must_equal false
    end
    it 'does not allow to new' do
      subject.new?.must_equal false
    end
  end

  describe 'as an admin' do
    let(:user)  { FactoryGirl.build :admin }
    subject     { CategoryPolicy.new(user, category) }

    it 'does not allow to manage' do
      subject.manage?.must_equal true
    end
    it 'does not allow to edit' do
      subject.edit?.must_equal true
    end
    it 'does not allow to upate' do
      subject.update?.must_equal true
    end
    it 'does not allow to destroy' do
      subject.destroy?.must_equal true
    end
    it 'does not allow to create' do
      subject.create?.must_equal true
    end
    it 'does not allow to new' do
      subject.new?.must_equal true
    end
  end
end