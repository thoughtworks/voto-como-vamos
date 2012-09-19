require 'spec_helper'

describe Comment do
  it { should validate_presence_of :proposal }
  it { should validate_presence_of :user }

  it "sends a notification to the proposal owner (candidate) when created" do
    message = double('message')
    message.should_receive(:deliver)
    CandidateMailer.should_receive(:notify_comment).and_return(message)
    FactoryGirl.create :comment
  end
end
