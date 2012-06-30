# encoding: utf-8
require 'spec_helper'

describe OwnershipsController do
  context 'not logged in' do
    before(:each) do
      @controller.request.should_receive(:fullpath).any_number_of_times.and_return('http://example.org/candidates/1')
      get :new
    end
    
    it 'should store the original request in order to redirect after logon' do
      session[:return_to].should == 'http://example.org/candidates/1'
    end

    it { should redirect_to('/auth/facebook') }
  end

  describe 'new' do
    before(:each) do
      controller.stub!(current_user: true)
      get :new
    end
    it { should respond_with(:success) }
    it { should render_template('new') }
  end
end
