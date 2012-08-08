require 'spec_helper'

describe OpinionsController do

  before do
    controller.stub!(:current_user => current_user)
    request.env["HTTP_REFERER"] = 'back'
  end

  let(:opinion) {  mock_model(Opinion, value: -1) }
  let(:current_user) { mock_model(User) }
  let ( :proposal_id ) { 1 }

  describe "create" do
    let ( :data_params ) { {
      "proposal_id" => proposal_id.to_s,
      "value"       => "1",
      "user_id"     => current_user.id
    }}

    before do
      Opinion.should_receive(:create)
      .with(data_params, :as => :admin)
      .and_return(opinion)

      put :create, opinion: { proposal_id: proposal_id, value: 1 }
    end

    it { should respond_with(:redirect) }

  end


  describe "destroy" do

    before do
      Opinion.should_receive(:where)
      .with(user_id: current_user.id, id: opinion.id.to_s)
      .and_return([opinion])

      opinion.should_receive(:destroy).and_return true

      delete :destroy, { id: opinion.id }
    end

    it { should respond_with(:redirect) }
  end

  describe "update" do

    let(:value) { "-1" }

    before do
      Opinion.should_receive(:where)
      .with(user_id: current_user.id, id: opinion.id.to_s)
      .and_return([opinion])

      opinion.should_receive(:update_attributes).with(value: value).and_return true

      put :update, id: opinion.id,  opinion: { proposal_id: proposal_id, value: value }
    end

    it { should respond_with(:redirect) }

  end

  context "No HTTP Referrer" do
    before do
      request.env["HTTP_REFERER"] = nil

      Opinion.should_receive(:where)
      .with(user_id: current_user.id, id: opinion.id.to_s)
      .and_return([opinion])

      opinion.should_receive(:destroy).and_return true
      opinion.should_receive(:proposal).and_return mock(Proposal)

      delete :destroy, { id: opinion.id }
    end

    it { should respond_with(:redirect) }
  end

end
