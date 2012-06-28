require "spec_helper"

describe CandidateMailer do
  describe "renvidicate profile notifiction" do
    it "should render successfully" do
      candidate = double(:email => 'candidato@example.com')

      Candidate.should_receive(:find).with(1).and_return(candidate) 

      expect { CandidateMailer.revindication(1) }.
        to_not raise_error
    end
  end
end
