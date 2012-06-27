require 'spec_helper'

describe RevindicationObserver do
  it 'should send a revindication to the candidate' do
    obs = RevindicationObserver.instance
    revindication = mock_model(Revindication, :user_id => 1, :candidate_id => 2)
    mail = double('Mail') 
    CandidateMailer.should_receive(:revindication).with(2, 1).and_return(mail)
    mail.should_receive(:deliver).and_return(true)
    obs.after_commit(revindication)
  end
end
