# encoding: utf-8

require 'spec_helper'

describe CandidatesController do
  let(:candidate_id) { '1' }
  let(:candidate) { double('candidate', :id => candidate_id) }
  
  before :each do
    controller.stub!(current_user: true)
  end

  describe 'showing' do
    before(:each) do
      Candidate.should_receive(:find).with(candidate_id).and_return(candidate)
      get :show, {:id => candidate_id }
    end

    it { should respond_with(:success) }
    it { should assign_to(:candidate).with(candidate) }
    it { should render_template('show') }
  end

  describe 'editing' do
    before(:each) do
      Candidate.should_receive(:find).with(candidate_id).and_return(candidate)
      get :edit, {:id => candidate_id }
    end
    
    it { should respond_with(:success) }
    it { should assign_to(:candidate).with(candidate)}
    it { should render_template('edit') }
  end

  describe 'updating' do
    before(:each) do
      params = {'name' => 'fulaninho', 'email' => 'e@mail.com'}
      Candidate.should_receive(:find).with(candidate_id).and_return(candidate)
      candidate.should_receive(:update_attributes).with(params)
      post :update, :id => candidate_id, :candidate => params
    end

    it { should respond_with(:redirect) }
    it { should assign_to(:candidate).with(candidate) }
    it { should redirect_to candidate_path(candidate_id) }
  end
end