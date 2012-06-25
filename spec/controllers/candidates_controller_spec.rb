# encoding: utf-8

require 'spec_helper'

describe CandidatesController do
  let(:candidate_id) { '1' }
  let(:candidate) { double('candidate', :id => candidate_id) }

  before :each do
    controller.stub!(current_user: true)
    Candidate.should_receive(:find).with(candidate_id).and_return(candidate)
  end

  describe 'showing' do
    before(:each) do
      get :show, {:id => candidate_id }
    end

    it { should respond_with(:success) }
    it { should assign_to(:candidate).with(candidate) }
    it { should render_template('show') }
  end

  describe 'editing' do
    before(:each) do
      get :edit, {:id => candidate_id }
    end

    it { should respond_with(:success) }
    it { should assign_to(:candidate).with(candidate)}
    it { should render_template('edit') }
  end

  describe 'updating' do
    before(:each) do
      params = { 'name' => 'fulaninho', 'email' => 'e@mail.com'}
      candidate.should_receive(:update_attributes).with(params).and_return(true)
      post :update, :id => candidate_id, :candidate => params
    end

    it { should respond_with(:redirect) }
    it { should assign_to(:candidate).with(candidate) }
    it { should redirect_to candidate_path(candidate_id) }
  end
  
  describe 'updating with error' do
    before(:each) do
      params = {'phone' => 'invalid'}
      candidate.should_receive(:update_attributes).with(params).and_return(false)
      post :update, :id => candidate_id, :candidate => params
    end
    
    it{ should render_template('edit') }
  end
end
