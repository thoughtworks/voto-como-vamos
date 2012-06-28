require 'spec_helper'

describe Revindication do
  it { should belong_to(:candidate) }
  it { should belong_to(:user) }

  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:candidate) }
  describe "has being send for all candidates" do
    it "should send an email for each candidate" do
      candidates = [ double('candidate1', id: 1, email: 'test1@candidate.com'),
                     double('candidate2', id: 2, email: 'test2@candidate.com') ]
      Candidate.should_receive(:all).and_return(candidates)

      CandidateMailer.should_receive(:send_message_for_revindication).with(1)
      CandidateMailer.should_receive(:send_message_for_revindication).with(2)

      Revindication.send_to_all_candidates

    end
  end
end
