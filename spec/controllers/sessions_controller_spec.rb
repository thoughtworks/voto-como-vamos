require 'spec_helper'

describe SessionsController do
  let(:auth) do
    { 'provider' => 'facebook',
      'uid' => 1 }
  end

  let(:user) { double('user', :id => 1) }

  before do
    controller.stub!(:auth_hash).and_return(auth)
  end

  context "user exists" do
    before do
      User.should_receive(:find_by_provider_and_uid)
        .with(auth['provider'], auth['uid'])
        .and_return(user)
      post 'create'
    end

    it "log the user" do
      session[:user_id].should == 1
    end

    it "redirect to root path" do
      response.should redirect_to(root_path)
    end
  end

  context "user doesn't exists" do
    before do
      User.should_receive(:find_by_provider_and_uid)
        .with(auth['provider'], auth['uid'])
        .and_return(nil)
    end

    context "creating user with success" do
      before do
        User.should_receive(:create_with_auth)
          .with(auth)
          .and_return(user)
        post 'create'
      end

      it "log the user" do
         session[:user_id].should == 1
      end

      it "redirect to root path with canvas" do
        response.should redirect_to(root_path(:canvas => true))
      end
    end
  end
end
