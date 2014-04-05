require 'test_helper'

describe Tf2ClassesController do

  describe 'as admin' do
    it 'must get new' do
      as_logged_in_admin do
        get :new
        response.status.must_equal 200
      end
    end

    it 'must get manage' do
      as_logged_in_admin do
        FactoryGirl.create(:tf2_class)
        get :manage
        assigns(:tf2_classes).size.must_equal 1
        response.status.must_equal 200
      end
    end

    it 'must create a tf2 class' do
      as_logged_in_admin do
        Tf2Class.count.must_equal 0
        post :create, :tf2_class => FactoryGirl.attributes_for(:tf2_class)
        flash[:notice].wont_be_nil
        Tf2Class.count.must_equal 1
        response.status.must_equal 302
      end
    end

    it 'must not create invalid tf2 classes' do
      as_logged_in_admin do
        post :create, :tf2_class => FactoryGirl.attributes_for(:tf2_class, :name => '')
        flash[:alert].wont_be_nil
        response.status.must_equal 302
        Tf2Class.count.must_equal 0
      end
    end

    it 'must get edit' do
      as_logged_in_admin do
        tf2_class = FactoryGirl.create :tf2_class
        get :edit, 'id' => tf2_class.friendly_id
        assigns(:tf2_class).must_equal tf2_class
        response.status.must_equal 200
      end
    end

    it 'must update a tf2 class' do
      as_logged_in_admin do
        tf2_class = FactoryGirl.create :tf2_class
        post :update, :id => tf2_class.friendly_id, :tf2_class => FactoryGirl.attributes_for(:tf2_class)
        flash[:notice].wont_be_nil
        response.status.must_equal 302
      end
    end

    it 'must not update invalid tf2 classes' do
      as_logged_in_admin do
        tf2_class = FactoryGirl.create :tf2_class
        post :update, :id => tf2_class.friendly_id, :tf2_class => FactoryGirl.attributes_for(:tf2_class, :name => '')
        flash[:alert].wont_be_nil
        response.status.must_equal 302
      end
    end

    it 'must destroy a tf2 class' do
      as_logged_in_admin do
        tf2_class = FactoryGirl.create :tf2_class
        Tf2Class.count.must_equal 1
        delete :destroy, :id => tf2_class.friendly_id
        flash[:notice].wont_be_nil
        response.status.must_equal 302
        Tf2Class.count.must_equal 0
      end
    end
  end
end