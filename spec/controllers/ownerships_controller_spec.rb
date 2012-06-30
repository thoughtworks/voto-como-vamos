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
  context 'logged in' do
    let(:candidate_id) { '1' }
    let(:candidate)    { double('Candidate') }
    let(:current_user) { double('User') }
    let(:ownership)    { double('Ownership') }

    before(:each) do
      controller.stub!(current_user: current_user)
      Candidate.should_receive(:find).with(candidate_id).and_return(candidate)
    end

    describe 'new' do
      before(:each) do
        get :new, :candidate_id => candidate_id
      end
      it { should respond_with(:success) }
      it { should render_template('new') }
    end

    describe 'create' do
      let(:fake_params) do
        {
          'ownership' => {
            'terms_and_conditions' => '1'
          },
          'candidate_id' => candidate_id
        }
      end

      context 'when input is valid' do
        before do
          Ownership.should_receive(:new).with(fake_params['ownership']).and_return(ownership)
          ownership.should_receive(:candidate=).with(candidate)
          ownership.should_receive(:user=).with(current_user)

          ownership.should_receive(:save).and_return(true)

          post :create, fake_params
        end

        it { should respond_with(:redirect) }
        it { should redirect_to(edit_candidate_path(candidate)) }
      end

      context 'when input is invalid' do
        before do
          Ownership.should_receive(:new).with(fake_params['ownership']).and_return(ownership)
          ownership.should_receive(:candidate=).with(candidate)
          ownership.should_receive(:user=).with(current_user)

          ownership.should_receive(:save).and_return(false)

          post :create, fake_params
        end
        it { should render_template(:new) }
      end
    end
  end
end
