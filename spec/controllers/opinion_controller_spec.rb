require 'spec_helper'

describe OpinionController do

  before do
    controller.stub!(:current_user => current_user)
  end

  let(:current_user) { mock_model(User) }

  describe "create" do
    let ( :opinion ) {  mock_model(Opinion) } 
    let ( :proposal_id ) { 1 }
    let ( :data_params ) { { 
      "proposal_id" => proposal_id.to_s,
      "agree"       => true,
      "user_id"     => current_user.id
    }}

    before do
      Opinion.should_receive(:create)
      .with(data_params)
      .and_return(opinion)

      put :create, opinion: { proposal_id: proposal_id, agree: true }
    end

    it { should respond_with(:redirect) }

  end

end
