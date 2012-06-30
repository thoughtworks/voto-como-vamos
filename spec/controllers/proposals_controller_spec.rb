# encoding: utf-8

require 'spec_helper'

describe ProposalsController do
  let(:candidate_id) { '1' }
  let(:candidate)    { stub('candidate', :id => candidate_id) }
  let(:proposal)     { mock('proposal') }

  before :each do
    controller.stub!(:current_user => true)
    Candidate.should_receive(:find).with(candidate_id).and_return(candidate)
  end

  describe '#new' do

    before do
      Proposal.should_receive(:new).
               with({:candidate_id => candidate_id}).
               and_return(proposal)
      get :new, {:candidate_id => candidate_id}
    end

    it { should respond_with(:success) }
    it { should assign_to(:proposal).with(proposal) }
    it { should render_template('new') }
  end

  describe '#create' do
    let(:fake_params) do
      {
        'proposal' => {
          'title' => 'Foo',
          'category_ids' => ['1', '2', '3']
        },
        'candidate_id' => candidate_id
      }
    end

    context 'when input is valid' do
      before do
        Proposal.should_receive(:new).with(fake_params['proposal']).and_return(proposal)
        proposal.should_receive(:candidate=).with(candidate)
        proposal.should_receive(:save).and_return(true)

        post :create, fake_params
      end

      it { should respond_with(:redirect) }
      it { should redirect_to(candidate_path(candidate)) }
    end

    context 'when input is invalid' do
      before do
        Proposal.should_receive(:new).with(fake_params['proposal']).and_return(proposal)
        proposal.should_receive(:candidate=).with(candidate)
        proposal.should_receive(:save).and_return(false)

        post :create, fake_params
      end

      it { should render_template(:new) }
    end
  end

end
