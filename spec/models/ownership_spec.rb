require 'spec_helper'

describe Ownership do
  it { should belong_to :user }
  it { should belong_to :candidate }

  it { should validate_acceptance_of :terms_and_conditions }
  it { should validate_presence_of :user }
  it { should validate_presence_of :candidate }

  describe "has being send for some candidates" do
    it "should send an email for each candidate" do
      candidates = [ double('candidate1', id: 1, email: 'test1@candidate.com'),
                     double('candidate2', id: 2, email: 'test2@candidate.com'),
                     double('candidate3', id: 3, email: 'test3@candidate.com'),
                     double('candidate4', id: 4, email: 'test4@candidate.com') ]
      Candidate.stub_chain(:where, :order).and_return(candidates)

      message1 = double('Message 1', :deliver => true)
      message2 = double('Message 2', :deliver => true)
      message3 = double('Message 3', :deliver => true)

      CandidateMailer.should_receive(:claim).with(1).and_return(message1)
      CandidateMailer.should_receive(:claim).with(2).and_return(message2)
      CandidateMailer.should_receive(:claim).with(3).and_return(message3)

      Ownership.send_claim_to_some_candidates(0, 2)
    end
  end
end
