require "spec_helper"

describe CandidateMailer do
  describe "renvidicate profile notifiction" do
    it "should render successfully" do
      user = double(:email => 'user@example.com', :name => 'Fulano de Tal')
      candidate = double(:email => 'candidato@example.com')

      Candidate.should_receive(:find).with(1).and_return(candidate) 
      User.should_receive(:find).with(1).and_return(user)

      expect { CandidateMailer.revindication(1, 1) }.
        to_not raise_error
    end
  end
end
