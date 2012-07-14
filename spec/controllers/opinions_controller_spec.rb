require 'spec_helper'

describe OpinionsController do

  before do
    controller.stub!(:current_user => current_user)
  end

  let(:opinion) {  mock_model(Opinion) } 
  let(:current_user) { mock_model(User) }
  let ( :proposal_id ) { 1 }

  describe "create" do
    let ( :data_params ) { { 
      "proposal_id" => proposal_id.to_s,
      "agree"       => true,
      "user_id"     => current_user.id
    }}

    before do
      Opinion.should_receive(:create)
      .with(data_params, :as => :admin)
      .and_return(opinion)

      put :create, opinion: { proposal_id: proposal_id, agree: true }
    end

    it { should respond_with(:redirect) }

  end


  describe "destroy" do

    before do
      Opinion.should_receive(:where)
      .with(user_id: current_user.id, id: opinion.id.to_s)
      .and_return([opinion])

      opinion.should_receive(:destroy).and_return true
      opinion.should_receive(:proposal_id).and_return proposal_id

      delete :destroy, { id: opinion.id }
    end

    it { should respond_with(:redirect) }
  end
end
