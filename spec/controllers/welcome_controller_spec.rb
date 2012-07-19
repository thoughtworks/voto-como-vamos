require 'spec_helper'

describe WelcomeController do
  let(:categories) do
    [double('category1'), double('category2')]
  end
  let(:ordered_votes) { double("limited", limit: []) }

  before :each do
    controller.stub!(current_user: true)
  end

  context 'landing outside facebook' do
    before(:each) do
      Category.should_receive(:all).and_return(categories)
      Proposal.should_receive(:ordered_by_votes).and_return(ordered_votes)
      get :index
    end

    it { should respond_with(:success) }
    it { should assign_to(:categories).with(categories) }
    it { should render_template('index') }
  end

  context 'running inside facebook canvas' do
    before(:each) do
      get :index, :canvas => true
    end

    it { should redirect_to Settings.facebook_app_url }
  end
end
