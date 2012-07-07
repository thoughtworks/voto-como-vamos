require 'spec_helper'

describe Ownership do
  it { should belong_to :user }
  it { should belong_to :candidate }
  it { should validate_acceptance_of :terms_and_conditions }
  it { should validate_presence_of :user }
  it { should validate_presence_of :candidate }

  describe "has being send for all candidates" do
    it "should send an email for each candidate" do
      candidates = [ double('candidate1', id: 1, email: 'test1@candidate.com'),
                     double('candidate2', id: 2, email: 'test2@candidate.com') ]
      Candidate.should_receive(:all).and_return(candidates)

      message1 = double('Message 1', :deliver => true)
      message2 = double('Message 2', :deliver => true)

      CandidateMailer.should_receive(:revindication).with(1).and_return(message1)
      CandidateMailer.should_receive(:revindication).with(2).and_return(message2)

      Ownership.send_revindication_to_all_candidates
    end
  end
end
