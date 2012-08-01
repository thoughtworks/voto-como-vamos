require 'spec_helper'

describe PartiesController do

  describe "index" do
    let(:parties) {["PT", "PV", "PC do B"]}

    before do
      Candidate.stub_chain(:order, :uniq, :pluck).and_return(parties)
      get :index
    end

    it { should assign_to(:parties).with(parties) }
    it { should respond_with(:success) }
    it { should render_template(:index) }
  end

  describe "show" do
    let(:party_id) { '1' }
    let(:candidates) { [double('candidate 1'), double('candidate 2')] }

    before do
      Candidate.stub_chain(:where, :order).and_return(candidates)
      get :show, :id => party_id
    end

    it { should assign_to(:candidates).with(candidates) }
    it { should respond_with(:success) }
    it { should render_template(:show) }
  end

end
