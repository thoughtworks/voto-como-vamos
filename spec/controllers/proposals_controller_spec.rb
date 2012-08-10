# encoding: utf-8
require 'spec_helper'

describe ProposalsController do
  before :each do
    controller.stub!(:current_user => true)
  end

  let(:proposal)     { mock_model(Proposal)}
  let(:candidate_id) { '1' }
  let(:candidate)    { stub('candidate', :id => candidate_id) }
  let(:arguments) { {include: {questions: :user}} }

  describe '#show' do
    let(:proposal_id) { '1' }
    let(:fake_params) do
      {
        :candidate_id => candidate_id,
        :id           => proposal_id
      }
    end

    before do
      Proposal.should_receive(:find).with(proposal_id, arguments).and_return(proposal)
      proposal.should_receive(:candidate).and_return(candidate)
      get :show, fake_params
    end

    it { should assign_to(:candidate).with(candidate) }
    it { should assign_to(:proposal).with(proposal) }
    it { should respond_with(:success) }
    it { should render_template(:show) }
  end

  describe 'filtered listing' do
    let(:proposals) { [double('proposal1'), double('proposal2')] }
    let(:category) {[double('Category')]}

    it 'search by category when specified' do
      Proposal.stub_chain(:search_in_categories, :results).and_return(proposals)
      Category.should_receive(:find).with(['Test']).and_return(category)
      proposals.should_receive(:shuffle).and_return(proposals)
      get :index, :categories => ['Test']

      should respond_with(:success)
      should assign_to(:proposals).with(proposals)
      should assign_to(:categories).with(category)
      should render_template('index')
    end

    it 'search by text criteria when specified' do
      Proposal.stub_chain(:search_in_categories, :results).and_return(proposals)
      Category.should_receive(:find).with(nil).and_return(nil)
      proposals.should_receive(:shuffle).and_return(proposals)
      get :index, :query => 'test'

      should respond_with(:success)
      should assign_to(:proposals).with(proposals)
      should render_template('index')
    end
  end

  context 'for the proposals page' do
    before do
      Proposal.should_receive(:all, :order => "random()", :limit => 5)
    end

    it 'shows proposals sorted randomly' do
      get :random_listing
    end
  end

  context 'for a specified candidate' do
    before :each do
      Candidate.should_receive(:find).with(candidate_id).and_return(candidate)
      candidate.should_receive(:represented_by?).with(true).and_return(true)
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

        it { should assign_to(:candidate).with(candidate) }
        it { should assign_to(:proposal).with(proposal) }
        it { should render_template(:new) }
      end
    end

    describe "#edit" do
      let(:proposal_id) { "1" }
      let(:proposals_collection) { mock('proposals') }

      before do
        candidate.should_receive(:proposals).
          and_return(proposals_collection)

        proposals_collection.should_receive(:find).
          with(proposal_id).
          and_return(proposal)

        get :edit, {:candidate_id => candidate_id, :id => proposal_id}
      end

      it { should respond_with(:success) }
      it { should assign_to(:proposal).with(proposal) }
      it { should render_template('edit') }
    end

    describe "#update" do
      let(:proposal_id) { "1" }
      let(:proposals_collection) { mock('proposals') }
      let(:proposal_params){ { "title" => "test" } }

      before do
        candidate.should_receive(:proposals).
          and_return(proposals_collection)

        proposals_collection.should_receive(:find).
          with(proposal_id).
          and_return(proposal)

        proposal.should_receive(:update_attributes).
          with(proposal_params).
          and_return(valid?)

        put :update, {
          :candidate_id => candidate_id,
          :id => proposal_id,
          :proposal => proposal_params
        }
      end

      context "when the proposal data is valid" do
        let(:valid?){ true }

        it { should respond_with(:redirect) }
        it { should assign_to(:proposal).with(proposal) }
        it { should redirect_to(candidate_path(candidate_id)) }
      end

      context "when the proposal data is not valid" do
        let(:valid?){ false }

        it { should respond_with(:success) }
        it { should assign_to(:proposal).with(proposal) }
        it { should render_template('edit') }
      end
    end

    describe '#delete' do
      let(:proposal_id) { '1' }
      let(:fake_params) do
        {
          :candidate_id => candidate_id,
          :proposal_id  => proposal_id
        }
      end

      before do
        Proposal.should_receive(:find).with(proposal_id).and_return(proposal)
        get :delete, fake_params
      end

      it { should assign_to(:candidate).with(candidate) }
      it { should assign_to(:proposal).with(proposal) }
      it { should respond_with(:success) }
      it { should render_template(:delete) }
    end

    describe '#destroy' do
      let(:proposal_id) { '1' }
      let(:fake_params) do
        {
          :candidate_id => candidate_id,
          :id           => proposal_id
        }
      end

      before do
        Proposal.should_receive(:find).with(proposal_id).and_return(proposal)
        proposal.should_receive(:delete)

        delete :destroy, fake_params
      end

      it { should respond_with(:redirect) }
      it { should redirect_to(candidate_path(candidate)) }
    end
  end

  context 'for a candidate that is not owned by the user' do
    let(:proposal_id) { "1" }
    let(:fake_params) do
      {
        :candidate_id => candidate_id,
        :proposal_id  => proposal_id
      }
    end

    before :each do
      Candidate.should_receive(:find).with(candidate_id).and_return(candidate)
      candidate.should_receive(:represented_by?).with(true).and_return(false)
    end

    it 'should redirect on new' do
      get :new, {:candidate_id => candidate_id}
      should respond_with(:redirect)
    end

    it 'should redirect on edit' do
      get :edit, {:candidate_id => candidate_id, :id => proposal_id}
      should respond_with(:redirect)
    end

    it 'should redirect on create' do
      post :create, {:candidate_id => candidate_id}
      should respond_with(:redirect)
    end

    it 'should redirect on update' do
      put :update, {
        :candidate_id => candidate_id,
        :id => proposal_id,
        :proposal => {}
      }
      should respond_with(:redirect)
    end

    it 'should redirect on delete' do
      get :delete, fake_params
      should respond_with(:redirect)
    end

    it 'should redirect on destroy' do
      delete :destroy, fake_params
      should respond_with(:redirect)
    end

  end
end
