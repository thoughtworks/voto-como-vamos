require 'spec_helper'

describe MainSearch do
  it 'can be made for both candidates and proposals' do
    search = MainSearch.new(:query => 'test')

    proposals = double('proposals')
    candidates = double('candidates')

    Proposal.should_receive(:text_search).with('test').and_return(proposals)
    Candidate.should_receive(:text_search).with('test').and_return(candidates)

    search.execute

    search.candidate_results.should == candidates
    search.proposal_results.should == proposals
  end
end
