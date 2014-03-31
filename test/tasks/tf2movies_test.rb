require 'test_helper'
require 'rake'
Tf2movies::Application.load_tasks


describe 'tf2movies' do
  describe 'adminify' do
    subject {Rake::Task['tf2movies:adminify']}
    it 'makes a user an admin' do
      subject.reenable
      u = FactoryGirl.create :user, :nickname => 'Bobby'
      proc { subject.invoke('Bobby') }.must_output /User Bobby is now an admin/, nil
      u.reload
      u.admin?.must_equal true
    end

    it 'complains when it cannot find the user' do
      subject.reenable
      proc { subject.invoke('alice') }.must_output /Could not find/
    end

    it 'complains when no argument is provided' do
      subject.reenable
      proc { subject.invoke }.must_output /No user name specified/
    end
  end

  describe 'check' do
    subject {Rake::Task['tf2movies:check']}
    it 'outputs no when environment variables are missing' do
      subject.reenable
      ENV = Hash.new
      proc { subject.invoke }.must_output /Running(.*no){5}.*Finished/m
    end

    it 'outputs yes when environment variables are set' do
      subject.reenable
      ENV = Hash.new('foo')
      proc { subject.invoke }.must_output /Running(.*yes){5}.*Finished/m
    end
  end
end