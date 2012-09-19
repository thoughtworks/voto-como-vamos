require "spec_helper"

describe CandidateMailer do
  describe "renvidicate profile notifiction" do
    it "should render successfully" do
      candidate = double(:email => 'candidato@example.com', :obfuscated_slug => '1')

      Candidate.should_receive(:find).with(1).and_return(candidate)

      expect { CandidateMailer.claim(1) }.
        to_not raise_error
    end
  end
  describe "comment notifiction" do
    it "should render successfully" do
      candidate = double(:name => 'Candidate Name', :email => 'candidate@email.com')
      proposal = double(:candidate => candidate)

      Proposal.should_receive(:find).with(1).and_return(proposal)

      expect { CandidateMailer.notify_comment(1) }.
        to_not raise_error
    end
  end
end
