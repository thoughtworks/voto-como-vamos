# encoding: utf-8

require 'spec_helper'

describe ProposalsController do
  before :each do
    controller.stub!(:current_user => true)
  end

  describe '#new' do
    let(:candidate_id) { '1' }
    let(:candidate)    { stub('candidate', :id => candidate_id) }
    let(:proposal)     { stub('proposal') }

    before do
      Candidate.should_receive(:find).with(candidate_id).and_return(candidate)
      Proposal.should_receive(:new).
               with({:candidate_id => candidate_id}).
               and_return(proposal)
      get :new, {:candidate_id => candidate_id}
    end

    it { should respond_with(:success) }
    it { should assign_to(:proposal).with(proposal) }
    it { should render_template('new') }
  end

end
